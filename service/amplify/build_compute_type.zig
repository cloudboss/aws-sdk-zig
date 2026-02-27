pub const BuildComputeType = enum {
    standard_8_gb,
    large_16_gb,
    xlarge_72_gb,

    pub const json_field_names = .{
        .standard_8_gb = "STANDARD_8GB",
        .large_16_gb = "LARGE_16GB",
        .xlarge_72_gb = "XLARGE_72GB",
    };
};
