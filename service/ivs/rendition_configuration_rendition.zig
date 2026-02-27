pub const RenditionConfigurationRendition = enum {
    sd,
    hd,
    full_hd,
    lowest_resolution,

    pub const json_field_names = .{
        .sd = "SD",
        .hd = "HD",
        .full_hd = "FULL_HD",
        .lowest_resolution = "LOWEST_RESOLUTION",
    };
};
