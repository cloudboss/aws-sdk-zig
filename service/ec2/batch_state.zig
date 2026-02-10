pub const BatchState = enum {
    submitted,
    active,
    cancelled,
    failed,
    cancelled_running,
    cancelled_terminating_instances,
    modifying,
};
