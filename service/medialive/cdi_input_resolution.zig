/// Maximum CDI input resolution; SD is 480i and 576i up to 30 frames-per-second
/// (fps), HD is 720p up to 60 fps / 1080i up to 30 fps, FHD is 1080p up to 60
/// fps, UHD is 2160p up to 60 fps
pub const CdiInputResolution = enum {
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
