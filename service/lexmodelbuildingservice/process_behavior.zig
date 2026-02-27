pub const ProcessBehavior = enum {
    save,
    build,

    pub const json_field_names = .{
        .save = "SAVE",
        .build = "BUILD",
    };
};
