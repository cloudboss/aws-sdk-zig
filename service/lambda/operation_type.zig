pub const OperationType = enum {
    execution,
    context,
    step,
    wait,
    callback,
    chained_invoke,

    pub const json_field_names = .{
        .execution = "EXECUTION",
        .context = "CONTEXT",
        .step = "STEP",
        .wait = "WAIT",
        .callback = "CALLBACK",
        .chained_invoke = "CHAINED_INVOKE",
    };
};
