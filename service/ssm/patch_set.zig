pub const PatchSet = enum {
    os,
    application,

    pub const json_field_names = .{
        .os = "Os",
        .application = "Application",
    };
};
