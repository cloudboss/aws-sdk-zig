pub const ContentResolution = enum {
    none,
    fhd,
    uhd,

    pub const json_field_names = .{
        .none = "NONE",
        .fhd = "FHD",
        .uhd = "UHD",
    };
};
