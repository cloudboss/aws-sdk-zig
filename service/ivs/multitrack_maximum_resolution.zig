pub const MultitrackMaximumResolution = enum {
    sd,
    hd,
    full_hd,

    pub const json_field_names = .{
        .sd = "SD",
        .hd = "HD",
        .full_hd = "FULL_HD",
    };
};
