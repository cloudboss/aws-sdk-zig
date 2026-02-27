pub const InstanceType = enum {
    dev_standard1_small,
    dev_standard1_medium,
    dev_standard1_large,
    dev_standard1_xlarge,

    pub const json_field_names = .{
        .dev_standard1_small = "DEV_STANDARD1_SMALL",
        .dev_standard1_medium = "DEV_STANDARD1_MEDIUM",
        .dev_standard1_large = "DEV_STANDARD1_LARGE",
        .dev_standard1_xlarge = "DEV_STANDARD1_XLARGE",
    };
};
