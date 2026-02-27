pub const LaunchDisposition = enum {
    stopped,
    started,

    pub const json_field_names = .{
        .stopped = "STOPPED",
        .started = "STARTED",
    };
};
