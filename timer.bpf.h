/* Copyright (c) Meta Platforms, Inc. and affiliates. */
#ifndef __LAYERED_TIMER_H
#define __LAYERED_TIMER_H
#include "bpftool/src/vmlinux.h"
#include <bpf/bpf_core_read.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

enum timer_consts {
	// kernel definitions
	CLOCK_BOOTTIME		= 7,
};

struct layered_timer {
	// if set to 0 the timer will only be scheduled once
	u64 interval_ns;
	u64 init_flags;
	int start_flags;
};

enum layer_timer_callbacks {
	LAYERED_MONITOR,
	ANTISTALL_TIMER,
	NOOP_TIMER,
	MAX_TIMERS,
};

bool run_timer_cb(int key);

extern struct layered_timer layered_timers[MAX_TIMERS];

int start_layered_timers(void);
#endif /* __LAYERED_TIMER_H */
