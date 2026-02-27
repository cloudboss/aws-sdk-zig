pub const CpuArchitectureType = enum {
    x86_64,
    arm64,

    pub const json_field_names = .{
        .x86_64 = "X86_64",
        .arm64 = "ARM64",
    };
};
