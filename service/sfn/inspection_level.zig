pub const InspectionLevel = enum {
    info,
    debug,
    trace,

    pub const json_field_names = .{
        .info = "INFO",
        .debug = "DEBUG",
        .trace = "TRACE",
    };
};
