pub const StackSetOperationStatus = enum {
    running,
    succeeded,
    failed,
    stopping,
    stopped,
    queued,
};
