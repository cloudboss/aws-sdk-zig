/// The architecture of the cores which are the targets of an update.
pub const UpdateTargetsArchitecture = enum {
    armv_6_l,
    armv_7_l,
    x_86_64,
    aarch_64,

    pub const json_field_names = .{
        .armv_6_l = "armv6l",
        .armv_7_l = "armv7l",
        .x_86_64 = "x86_64",
        .aarch_64 = "aarch64",
    };
};
