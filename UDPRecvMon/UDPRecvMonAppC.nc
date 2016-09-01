configuration UDPRecvMonAppC
{
}

implementation
{
  components MainC;
  components UDPRecvMonC;

  UDPRecvMonC.Boot -> MainC.Boot;
}
