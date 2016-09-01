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
  components MainC;
  components UDPSendMonC;
  UDPSendMonC.Boot -> MainC.Boot;

  components IPStackC;
  UDPSendMonC.RadioControl ->  IPStackC;

  /* Later ;-)
  components new UdpSocketC() as UDPSend;
  UDPSendMonC.UDPSend -> UDPSend;
  */
}
