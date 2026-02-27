pub const IdleRecommendationFilterName = enum {
    finding,
    resource_type,

    pub const json_field_names = .{
        .finding = "FINDING",
        .resource_type = "RESOURCE_TYPE",
    };
};
