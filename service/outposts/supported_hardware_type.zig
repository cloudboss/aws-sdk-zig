pub const SupportedHardwareType = enum {
    rack,
    server,

    pub const json_field_names = .{
        .rack = "RACK",
        .server = "SERVER",
    };
};
