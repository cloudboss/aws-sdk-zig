pub const RuntimeEnvironmentType = enum {
    proton,
    windows,
    ubuntu,

    pub const json_field_names = .{
        .proton = "PROTON",
        .windows = "WINDOWS",
        .ubuntu = "UBUNTU",
    };
};
