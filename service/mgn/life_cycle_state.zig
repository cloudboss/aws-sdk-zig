pub const LifeCycleState = enum {
    stopped,
    not_ready,
    ready_for_test,
    testing,
    ready_for_cutover,
    cutting_over,
    cutover,
    disconnected,
    discovered,
    pending_installation,

    pub const json_field_names = .{
        .stopped = "STOPPED",
        .not_ready = "NOT_READY",
        .ready_for_test = "READY_FOR_TEST",
        .testing = "TESTING",
        .ready_for_cutover = "READY_FOR_CUTOVER",
        .cutting_over = "CUTTING_OVER",
        .cutover = "CUTOVER",
        .disconnected = "DISCONNECTED",
        .discovered = "DISCOVERED",
        .pending_installation = "PENDING_INSTALLATION",
    };
};
