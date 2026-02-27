pub const VirtualClusterState = enum {
    running,
    terminating,
    terminated,
    arrested,

    pub const json_field_names = .{
        .running = "RUNNING",
        .terminating = "TERMINATING",
        .terminated = "TERMINATED",
        .arrested = "ARRESTED",
    };
};
