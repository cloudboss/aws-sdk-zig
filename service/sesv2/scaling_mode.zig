pub const ScalingMode = enum {
    standard,
    managed,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .managed = "MANAGED",
    };
};
