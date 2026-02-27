pub const VideoResolution = enum {
    none,
    hd,
    fhd,

    pub const json_field_names = .{
        .none = "NONE",
        .hd = "HD",
        .fhd = "FHD",
    };
};
