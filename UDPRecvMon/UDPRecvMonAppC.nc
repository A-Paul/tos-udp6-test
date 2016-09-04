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

  components IPStackC;
  UDPRecvMonC.RadioControl -> IPStackC;

  components IPDispatchC;
}
