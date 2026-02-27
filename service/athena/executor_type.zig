pub const ExecutorType = enum {
    coordinator,
    gateway,
    worker,

    pub const json_field_names = .{
        .coordinator = "COORDINATOR",
        .gateway = "GATEWAY",
        .worker = "WORKER",
    };
};
