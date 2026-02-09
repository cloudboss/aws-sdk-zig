pub const OperationAction = enum {
    start,
    succeed,
    fail,
    retry,
    cancel,
};
