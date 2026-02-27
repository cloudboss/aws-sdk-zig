/// The rule schema version in this particular cost category.
pub const CostCategoryRuleVersion = enum {
    cost_category_expression_v1,

    pub const json_field_names = .{
        .cost_category_expression_v1 = "CostCategoryExpressionV1",
    };
};
