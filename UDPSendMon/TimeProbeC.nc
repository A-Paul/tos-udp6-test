/*
 * Copyright (C) 2016 Hamburg University of Applied Sciences
 *
 * This file is subject to the terms and conditions of the GNU Lesser
 * General Public License v2.1. See the file LICENSE in the top level
 * directory for more details.
 */

/**
 *
 * @brief Measure time differences.
 *
 *
 * @author  Andreas "Paul" Pauli <andreas.pauli@haw-hamburg.de>
 *
 */
configuration TimeProbeC
{
  provides interface StdControl;
  provides interface Get<uint32_t>;
}

implementation
{
  components TimeProbeP;
  components LocalTimeMicroC;

  TimeProbeP.LocalTime -> LocalTimeMicroC;
  TimeProbeP.StdControl = StdControl;
  TimeProbeP.Get = Get;
}
