/// Resolution based on lines of vertical resolution; SD is less than 720 lines,
/// HD is 720 to 1080 lines, FHD is 1080 lines, UHD is greater than 1080 lines
pub const ReservationResolution = enum {
    sd,
    hd,
    fhd,
    uhd,

    pub const json_field_names = .{
        .sd = "SD",
        .hd = "HD",
        .fhd = "FHD",
        .uhd = "UHD",
    };
};
