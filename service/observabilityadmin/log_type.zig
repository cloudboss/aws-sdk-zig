pub const LogType = enum {
    application,
    usage,

    pub const json_field_names = .{
        .application = "APPLICATION",
        .usage = "USAGE",
    };
};
