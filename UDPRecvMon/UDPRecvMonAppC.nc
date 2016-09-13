#include "printf.h"
/*
 * Application configuration for UDPRecvMon.
 */
configuration UDPRecvMonAppC
{
}

implementation
{
  /*
   * Let the App be started at boot time
   */
  components UDPRecvMonC, MainC;
  UDPRecvMonC.Boot -> MainC.Boot;

  /* Put before "IPStackC". Otherwise printf will *fuck you*!!! */
  components SerialPrintfC;

  components IPStackC;
  UDPRecvMonC.RadioControl -> IPStackC.SplitControl;

  components new UdpSocketC() as PacketSend;
  UDPRecvMonC.PacketSend -> PacketSend;
}
