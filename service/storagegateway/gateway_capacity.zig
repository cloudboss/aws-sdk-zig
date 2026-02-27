pub const GatewayCapacity = enum {
    small,
    medium,
    large,

    pub const json_field_names = .{
        .small = "Small",
        .medium = "Medium",
        .large = "Large",
    };
};
