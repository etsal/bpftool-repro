#pragma once

char *format_cgrp_path(struct cgroup *cgrp);
bool __noinline match_prefix(const char *prefix, const char *str, u32 max_len);
