pub const FrameworkType = enum {
    standard,
    custom,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .custom = "CUSTOM",
    };
};
