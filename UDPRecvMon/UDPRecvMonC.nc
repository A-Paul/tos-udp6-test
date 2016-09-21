#include "../include/UDP6Test.h"
/*
 * Application body for UDPRecvMon.
 *
 * @author  Andreas "Paul" Pauli <andreas.pauli@haw-hamburg.de>
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

  uses { /* Measure time difference */
    interface Get<uint32_t> as TimeProbeGet;
    interface StdControl as TimeProbeControl;
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

  /* signaled on each packet arrival on port 'UDP6_TEST_PORT' */
  event void PacketSend.recvfrom( struct sockaddr_in6 *src,
				  void *payload,
				  uint16_t len,
				  struct ip6_metadata *meta)
  {
    call TimeProbeControl.stop();
    printf( " rx %lu %.*s\n rx_driver %lu\n rx_stack\n",
	    call TimeProbeGet.get(), 3, (char*)payload, 0L);
  }
}
