tos-udp6-test#payload-stack-timediff
====================================

---------------------

Simple code for sending and receiving a sequence of udp pakets.  
Written for *tinyOS* in *nesC* and intended to run on *Zolertia's* Z1 board.

Under tinyOS the z1 generate a local link address in the form:
``fe80::212:6d4c:4f00:$NODE_ID``
The *NODE_ID* can be set only at build time by appending it to the install target
``install.$NODE_ID``.  
The hexfile is copied, patched, flashed and the copy is deleted aferwards.

build
-----
UDPSendMon:
``make z1 blip install.1 bsl,ref,$BOARD_REF``

UDPRecvMon:
``make z1 blip install.2 bsl,ref,$BOARD_REF``

The unique *BOARD_REF* can be observed with *motelist* from the *tinyos-tools*.

Time measurement with TimeProbe:
--------------------------------

Two time differences are measured.
- On the sender side: The first time counter is sampled when invoking UDP.send() and the second when
the packet is transmited into the radio chip.
- On the receiver side: The first time counter is sampled right befor reading the arrived packet from the radio chip and the second when UDP.received offers the recieved payload.


A component has been implemented to provide a uniqe storage for timestamps (TMicro) including access methods to sample the timestamps and return the difference.  
**TimeProbe** provides the intefaces StdControl and Get to make the commands start, stop and get accessible.
`TimeProbeControl.start()` takes the first timestamp, `TimeProbeControl.start()` the second (if start has invoked before) and `TimeProbeGet.get()` returns the difference.

*Important: tinyOS Millies have 2^10 ticks per second and Micros 2^20.*

Code Locations
--------------

In *UDPSendMon/CC2420TransmitP.nc* :
```
570
571     if ( acquireSpiResource() == SUCCESS ) {
572       loadTXFIFO();
573       call TimeProbeControl.stop();
574     }
```

In *UDPRecvMon/CC2420ReveiveP.nc* :
```
212
213   /***************** InterruptFIFOP Events ****************/
214   async event void InterruptFIFOP.fired() {
215     call TimeProbeControl.start();
216     if ( m_state == S_STARTED ) {
```
