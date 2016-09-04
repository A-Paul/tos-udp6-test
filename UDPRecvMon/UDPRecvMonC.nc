/*
 * Application body for UDPRecvMon.
 */
module UDPRecvMonC
{
  uses {
    interface Boot;
    interface SplitControl as RadioControl;
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
}
