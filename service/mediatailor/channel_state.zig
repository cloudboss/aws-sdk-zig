pub const ChannelState = enum {
    running,
    stopped,

    pub const json_field_names = .{
        .running = "RUNNING",
        .stopped = "STOPPED",
    };
};
