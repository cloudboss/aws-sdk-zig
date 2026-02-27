pub const SecurityHubFeature = enum {
    security_hub,
    security_hub_v2,

    pub const json_field_names = .{
        .security_hub = "SECURITY_HUB",
        .security_hub_v2 = "SECURITY_HUB_V2",
    };
};
