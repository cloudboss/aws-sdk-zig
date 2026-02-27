pub const AutomationRuleFilterName = enum {
    name,
    recommended_action_type,
    status,
    rule_type,
    organization_configuration_rule_apply_order,
    account_id,

    pub const json_field_names = .{
        .name = "NAME",
        .recommended_action_type = "RECOMMENDED_ACTION_TYPE",
        .status = "STATUS",
        .rule_type = "RULE_TYPE",
        .organization_configuration_rule_apply_order = "ORGANIZATION_CONFIGURATION_RULE_APPLY_ORDER",
        .account_id = "ACCOUNT_ID",
    };
};
