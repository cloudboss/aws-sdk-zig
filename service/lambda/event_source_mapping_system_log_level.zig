pub const EventSourceMappingSystemLogLevel = enum {
    debug,
    info,
    warn,

    pub const json_field_names = .{
        .debug = "Debug",
        .info = "Info",
        .warn = "Warn",
    };
};
