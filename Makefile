APPDIRS := UDPSendMon UDPRecvMon

# existing boards in INET-Lab
A_TOS_BOARD ?= z1
A_TOS_REF_RECV ?= Z1RC5220
A_TOS_REF_SEND ?= Z1RC5190
A_NODE_ID_RECV ?= 2
A_NODE_ID_SEND ?= 1


all: udprecv udpsend

udprecv:
	cd UDPRecvMon && \
	make $(A_TOS_BOARD) blip install.$(A_NODE_ID_RECV) bsl,ref,$(A_TOS_REF_RECV)

udpsend:
	cd UDPSendMon && \
	make $(A_TOS_BOARD) blip install.$(A_NODE_ID_SEND) bsl,ref,$(A_TOS_REF_SEND)

docs:
	cd UDPRecvMon && \
	make $(A_TOS_BOARD) blip docs
	cd UDPSendMon && \
	make $(A_TOS_BOARD) blip docs
