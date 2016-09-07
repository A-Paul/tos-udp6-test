/*
 * Application configuration for UDPSendMon.
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

  components IPStackC;
  UDPSendMonC.RadioControl -> IPStackC.SplitControl;

  components UdpC;
  components new UdpSocketC() as PacketSend;
  UDPSendMonC.PacketSend -> PacketSend;

  components SerialStartC;
  components SerialPrintfC;
}
