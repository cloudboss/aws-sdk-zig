pub const S3BucketRegion = enum {
    ap_east_1,
    me_south_1,
    eu_south_1,
    af_south_1,

    pub const json_field_names = .{
        .ap_east_1 = "AP_EAST_1",
        .me_south_1 = "ME_SOUTH_1",
        .eu_south_1 = "EU_SOUTH_1",
        .af_south_1 = "AF_SOUTH_1",
    };
};
