/// Input resolution based on lines of vertical resolution in the input; SD is
/// less than 720 lines, HD is 720 to 1080 lines, UHD is greater than 1080 lines
pub const InputResolution = enum {
    sd,
    hd,
    uhd,

    pub const json_field_names = .{
        .sd = "SD",
        .hd = "HD",
        .uhd = "UHD",
    };
};
