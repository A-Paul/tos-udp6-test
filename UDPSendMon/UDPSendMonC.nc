#include "blip_printf.h"
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
  event void Boot.booted()
  {
    call RadioControl.start();
  }

  event void RadioControl.startDone( error_t e)
  {
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
}
