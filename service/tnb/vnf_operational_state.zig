pub const VnfOperationalState = enum {
    started,
    stopped,

    pub const json_field_names = .{
        .started = "STARTED",
        .stopped = "STOPPED",
    };
};
