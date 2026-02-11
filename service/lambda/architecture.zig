pub const Architecture = enum {
    x_86_64,
    arm_64,

    pub const json_field_names = .{
        .x_86_64 = "x86_64",
        .arm_64 = "arm64",
    };
};
