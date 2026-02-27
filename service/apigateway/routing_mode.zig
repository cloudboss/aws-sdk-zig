pub const RoutingMode = enum {
    base_path_mapping_only,
    routing_rule_only,
    routing_rule_then_base_path_mapping,

    pub const json_field_names = .{
        .base_path_mapping_only = "BASE_PATH_MAPPING_ONLY",
        .routing_rule_only = "ROUTING_RULE_ONLY",
        .routing_rule_then_base_path_mapping = "ROUTING_RULE_THEN_BASE_PATH_MAPPING",
    };
};
