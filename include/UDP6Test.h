#ifndef UDP6TEST_H
#define UDP6TEST_H

#define UDP6_TEST_PORT 23666
#define UDP6_TEST_TGT_IN6 Z1_SPECIFIC_IN6
/* Target node(s) */
/* telosb #14 */
#define TELOS_SPECIFIC_IN6 "fe80::212:6d45:509c:42a9"
/* Some iotlab-m3 under gnrc_networking@RIOT */
#define IOTM3_SPECIFIC_IN6 "fe80::3432:4833:46d8:9e2a"
/* Arbitrary Z1 built with ``install.2`` */
#define Z1_SPECIFIC_IN6 "fe80::212:6d4c:4f00:2"

#endif /* UDP6TEST_H */
