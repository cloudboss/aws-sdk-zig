pub const CoreNetworkPolicyAlias = enum {
    live,
    latest,

    pub const json_field_names = .{
        .live = "LIVE",
        .latest = "LATEST",
    };
};
