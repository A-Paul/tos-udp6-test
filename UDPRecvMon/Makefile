COMPONENT=UDPRecvMonAppC

# Should derive a local link address from (PANID) and TOS_NODE_ID, but
# seems quite ineffective. 
#PFLAGS += -DBLIP_DERIVE_SHORTADDRS

# Suppress creation of a global ipv6.
PFLAGS += -DIN6_NO_GLOBAL

# Needed by PrintfC, SerialPrintfC.
CFLAGS += -I$(TOSDIR)/lib/printf
PFLAGS += -DNEW_PRINTF_SEMANTICS -DPRINTUART_ENABLED

include $(MAKERULES)
