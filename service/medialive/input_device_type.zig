/// The type of the input device. For an AWS Elemental Link device that outputs
/// resolutions up to 1080, choose "HD".
pub const InputDeviceType = enum {
    hd,
    uhd,

    pub const json_field_names = .{
        .hd = "HD",
        .uhd = "UHD",
    };
};
