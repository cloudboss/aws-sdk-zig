pub const MultiSelectQuestionRuleCategoryAutomationCondition = enum {
    present,
    not_present,

    pub const json_field_names = .{
        .present = "PRESENT",
        .not_present = "NOT_PRESENT",
    };
};
