pub const MarketSegment = enum {
    enterprise,
    large,
    medium,
    small,
    micro,

    pub const json_field_names = .{
        .enterprise = "ENTERPRISE",
        .large = "LARGE",
        .medium = "MEDIUM",
        .small = "SMALL",
        .micro = "MICRO",
    };
};
