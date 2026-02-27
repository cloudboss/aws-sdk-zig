pub const Status = enum {
    building,
    ready,
    ready_basic_testing,
    failed,
    not_built,

    pub const json_field_names = .{
        .building = "BUILDING",
        .ready = "READY",
        .ready_basic_testing = "READY_BASIC_TESTING",
        .failed = "FAILED",
        .not_built = "NOT_BUILT",
    };
};
