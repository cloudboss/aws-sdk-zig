/// The operating system of the cores which are the targets of an update.
pub const UpdateTargetsOperatingSystem = enum {
    ubuntu,
    raspbian,
    amazon_linux,
    openwrt,

    pub const json_field_names = .{
        .ubuntu = "ubuntu",
        .raspbian = "raspbian",
        .amazon_linux = "amazon_linux",
        .openwrt = "openwrt",
    };
};
