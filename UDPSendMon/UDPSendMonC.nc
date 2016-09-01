/*
 * Application body for UDPSendMon.
 */
module UDPSendMonC
{
  uses {
    interface Boot;
    interface SplitControl as RadioControl;
    
    //interface UDP as TSockU;
  }
}

implementation
{
  event void Boot.booted()
  {
    call RadioControl.start();
  }
  
  event void RadioControl.startDone( error_t e) {
  }
  
  event void RadioControl.stopDone( error_t e) {
  }
}
