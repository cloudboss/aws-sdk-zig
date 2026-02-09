pub const OperationStatus = enum {
    started,
    pending,
    ready,
    succeeded,
    failed,
    cancelled,
    timed_out,
    stopped,
};
