pub const ConflictExceptionReason = enum {
    resource_name_conflict,
    pricing_rule_in_pricing_plan_conflict,
    pricing_plan_attached_to_billing_group_delete_conflict,
    pricing_rule_attached_to_pricing_plan_delete_conflict,
    write_conflict_retry,

    pub const json_field_names = .{
        .resource_name_conflict = "RESOURCE_NAME_CONFLICT",
        .pricing_rule_in_pricing_plan_conflict = "PRICING_RULE_IN_PRICING_PLAN_CONFLICT",
        .pricing_plan_attached_to_billing_group_delete_conflict = "PRICING_PLAN_ATTACHED_TO_BILLING_GROUP_DELETE_CONFLICT",
        .pricing_rule_attached_to_pricing_plan_delete_conflict = "PRICING_RULE_ATTACHED_TO_PRICING_PLAN_DELETE_CONFLICT",
        .write_conflict_retry = "WRITE_CONFLICT_RETRY",
    };
};
