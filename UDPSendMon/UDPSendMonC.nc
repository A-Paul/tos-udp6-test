#include <stdio.h>
#include "lib6lowpan/lib6lowpan.h" /* Just needed for ``htons()`` */
#include "../include/UDP6Test.h"
/**
 * Application body for UDPSendMon.
 *
 * @author  Andreas "Paul" Pauli <andreas.pauli@haw-hamburg.de>
 */
module UDPSendMonC
{
  uses { /* Booting stuff. */
    interface Boot;
    interface SplitControl as RadioControl;
    interface Timer<TMilli> as StartDelay;
  }

  uses { /* IP transmission */
    interface UDP as PacketSend;
    interface Timer<TMilli> as SendSequence;
  }
}

implementation
{

  /* Socket to target */
  struct sockaddr_in6 tgt_addr;
  uint32_t send_counter = 0;

  task void sendPacket();

  event void Boot.booted()
  {
    call RadioControl.start();
  }

  event void RadioControl.startDone( error_t error)
  {
    if(error == SUCCESS) {
      printf("RadioControl.start...OK\n");
      call PacketSend.bind(UDP6_TEST_PORT);
      /* Setup socket data for target */
      inet_pton6(UDP6_TEST_TGT_IN6, &tgt_addr.sin6_addr);
      tgt_addr.sin6_port = htons(UDP6_TEST_PORT);

      call StartDelay.startOneShot( UDP6_TEST_START_DELAY_MILLI);
    } else {
      printf("RadioControl.start...failed\n");
      call RadioControl.start();
    }
  }

  event void RadioControl.stopDone( error_t e)
  {
  }

  event void PacketSend.recvfrom( struct sockaddr_in6 *src,
				  void *payload,
				  uint16_t len,
				  struct ip6_metadata *meta)
  {
  }

  event void StartDelay.fired()
  {
    call SendSequence.startPeriodic( UDP6_TEST_SEND_DELAY_MILLI);
  }

  event void SendSequence.fired()
  {
    if (UDP6_TEST_SEND_COUNT > send_counter) {
      post sendPacket();
      send_counter++;
    } else {
      call SendSequence.stop();
    }
  }

  task void sendPacket()
  {
    static error_t send_result;
    char payload[UDP6_TEST_PAYLOAD_LEN] = {0};
    snprintf( payload, UDP6_TEST_PAYLOAD_LEN, "%03u Msg buffer w/20b", send_counter);
    printf("tx %03u\n", send_counter);
    send_result = call PacketSend.sendto( &tgt_addr, payload, UDP6_TEST_PAYLOAD_LEN);
  }
}
