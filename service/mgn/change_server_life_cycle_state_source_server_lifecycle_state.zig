pub const ChangeServerLifeCycleStateSourceServerLifecycleState = enum {
    ready_for_test,
    ready_for_cutover,
    cutover,

    pub const json_field_names = .{
        .ready_for_test = "READY_FOR_TEST",
        .ready_for_cutover = "READY_FOR_CUTOVER",
        .cutover = "CUTOVER",
    };
};
