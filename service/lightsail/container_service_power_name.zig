pub const ContainerServicePowerName = enum {
    nano,
    micro,
    small,
    medium,
    large,
    xlarge,

    pub const json_field_names = .{
        .nano = "nano",
        .micro = "micro",
        .small = "small",
        .medium = "medium",
        .large = "large",
        .xlarge = "xlarge",
    };
};
