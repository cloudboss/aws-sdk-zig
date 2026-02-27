pub const CostCategoryRuleType = enum {
    regular,
    inherited_value,

    pub const json_field_names = .{
        .regular = "REGULAR",
        .inherited_value = "INHERITED_VALUE",
    };
};
