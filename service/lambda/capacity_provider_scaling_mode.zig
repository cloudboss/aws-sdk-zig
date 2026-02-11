pub const CapacityProviderScalingMode = enum {
    auto,
    manual,

    pub const json_field_names = .{
        .auto = "Auto",
        .manual = "Manual",
    };
};
