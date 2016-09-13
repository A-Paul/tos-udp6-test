#include "../include/UDP6Test.h"
/*
 * Application body for UDPRecvMon.
 */
module UDPRecvMonC
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

  event void Boot.booted()
  {
    call RadioControl.start();
  }

  event void RadioControl.startDone( error_t error)
  {
    if(error == SUCCESS) {
      printf("RadioControl.start...OK\n");
      call PacketSend.bind(UDP6_TEST_PORT);
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
    /* This is nasty! And dangerous!! */
    printf("Payload (l:d): %.*s", len, (char*)payload);
    printfflush();
  }
}
