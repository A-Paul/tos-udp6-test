#include "blip_printf.h"
#include "../include/UDP6Test.h"
/**
 * Application body for UDPSendMon.
 */
module UDPSendMonC
{
  uses { /* Booting stuff. */
    interface Boot;
    interface SplitControl as RadioControl;
  }

  uses { /* IP transmission */
    interface UDP as PacketSend;
  }
}

implementation
{

  /* Socket to target */
  struct sockaddr_in6 tgt_addr;

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

      post sendPacket();
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

  task void sendPacket()
  {
    static char* payload = "Cooler-Scheiss\n";
    static uint16_t pl_len = 0x10;
    static error_t send_result;
    send_result = call PacketSend.sendto( &tgt_addr, payload, pl_len);

    printf("Send result: %d\n", send_result);
  }
}
