pub const ConfigRuleState = enum {
    active,
    deleting,
    deleting_results,
    evaluating,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deleting = "DELETING",
        .deleting_results = "DELETING_RESULTS",
        .evaluating = "EVALUATING",
    };
};
