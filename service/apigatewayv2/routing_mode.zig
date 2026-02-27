pub const RoutingMode = enum {
    api_mapping_only,
    routing_rule_only,
    routing_rule_then_api_mapping,

    pub const json_field_names = .{
        .api_mapping_only = "API_MAPPING_ONLY",
        .routing_rule_only = "ROUTING_RULE_ONLY",
        .routing_rule_then_api_mapping = "ROUTING_RULE_THEN_API_MAPPING",
    };
};
