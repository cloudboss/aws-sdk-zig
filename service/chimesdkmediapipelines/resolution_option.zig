pub const ResolutionOption = enum {
    hd,
    fhd,

    pub const json_field_names = .{
        .hd = "HD",
        .fhd = "FHD",
    };
};
