pub const IsolineZoneCategory = enum {
    congestion_pricing,
    environmental,
    vignette,

    pub const json_field_names = .{
        .congestion_pricing = "CONGESTION_PRICING",
        .environmental = "ENVIRONMENTAL",
        .vignette = "VIGNETTE",
    };
};
