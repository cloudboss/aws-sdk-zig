pub const TargetPlatformArch = enum {
    x86_64,
    x86,
    arm64,
    arm_eabi,
    arm_eabihf,

    pub const json_field_names = .{
        .x86_64 = "X86_64",
        .x86 = "X86",
        .arm64 = "ARM64",
        .arm_eabi = "ARM_EABI",
        .arm_eabihf = "ARM_EABIHF",
    };
};
