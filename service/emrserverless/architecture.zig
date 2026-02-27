pub const Architecture = enum {
    arm64,
    x86_64,

    pub const json_field_names = .{
        .arm64 = "ARM64",
        .x86_64 = "X86_64",
    };
};
