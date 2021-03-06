#include "printf.h"
/*
 * Application configuration for UDPSendMon.
 *
 * @author  Andreas "Paul" Pauli <andreas.pauli@haw-hamburg.de>
 */
configuration UDPSendMonAppC
{
}

implementation
{
  /*
   * Let the App be started at boot time
   */
  components UDPSendMonC, MainC;
  UDPSendMonC.Boot -> MainC.Boot;

  /* Initial (one time) inactivity peroid after booting. */
  components new TimerMilliC() as StartDelay;
  UDPSendMonC.StartDelay -> StartDelay;

  /* Periodic sending of packets. */
  components new TimerMilliC() as SendSequence;
  UDPSendMonC.SendSequence -> SendSequence;

  /* Put before "IPStackC". Otherwise printf will *fuck you*!!! */
  components SerialPrintfC;

  components IPStackC;
  UDPSendMonC.RadioControl -> IPStackC.SplitControl;

  components new UdpSocketC() as PacketSend;
  UDPSendMonC.PacketSend -> PacketSend;

  components TimeProbeC;
  UDPSendMonC.TimeProbeControl -> TimeProbeC;
  UDPSendMonC.TimeProbeGet ->  TimeProbeC;
}
