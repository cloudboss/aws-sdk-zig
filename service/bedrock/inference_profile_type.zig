pub const InferenceProfileType = enum {
    system_defined,
    application,

    pub const json_field_names = .{
        .system_defined = "SYSTEM_DEFINED",
        .application = "APPLICATION",
    };
};
