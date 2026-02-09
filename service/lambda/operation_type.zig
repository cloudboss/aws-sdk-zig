pub const OperationType = enum {
    execution,
    context,
    step,
    wait,
    callback,
    chained_invoke,
};
