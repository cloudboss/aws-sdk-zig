pub const DocumentScope = enum {
    application,
    session,

    pub const json_field_names = .{
        .application = "APPLICATION",
        .session = "SESSION",
    };
};
