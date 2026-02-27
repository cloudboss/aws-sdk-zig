pub const DataUploadFrequency = enum {
    pt5_m,
    pt10_m,
    pt15_m,
    pt30_m,
    pt1_h,

    pub const json_field_names = .{
        .pt5_m = "PT5M",
        .pt10_m = "PT10M",
        .pt15_m = "PT15M",
        .pt30_m = "PT30M",
        .pt1_h = "PT1H",
    };
};
