#include <errno.h>
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
module TimeProbeP
{
  uses interface LocalTime<TMicro> as LocalTime;

  provides {
    interface Get<uint32_t>;
    interface StdControl;
  }
}

implementation
{

  enum {
    NOT_STARTED = 0,
    IS_STARTED = 1,
  };

  static uint32_t time_val_start;
  static uint32_t time_val_stop;
  static uint32_t time_val_diff;
  static uint32_t started = 0;

  command uint32_t Get.get()
  {
    return time_val_diff;
  }

  command error_t StdControl.start()
  {
    error_t result = ERESERVE;

    if ( IS_STARTED == started) {
      result = EBUSY;
    } else {
      started = IS_STARTED;
      time_val_start = call LocalTime.get();
      time_val_diff = 0;
      result = SUCCESS;
    }

    return result;
  }

  command error_t StdControl.stop()
  {
    error_t result = ERESERVE;

    if ( IS_STARTED == started) {
      time_val_stop = call LocalTime.get();
      time_val_diff = time_val_stop - time_val_start;
      time_val_start = 0;
      time_val_stop = 0;
      started = NOT_STARTED;
      result = SUCCESS;
    } else {
      result = ECANCELED;
    }

    return result;
  }
}
