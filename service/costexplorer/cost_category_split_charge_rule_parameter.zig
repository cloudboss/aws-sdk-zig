const CostCategorySplitChargeRuleParameterType = @import("cost_category_split_charge_rule_parameter_type.zig").CostCategorySplitChargeRuleParameterType;

/// The parameters for a split charge method.
pub const CostCategorySplitChargeRuleParameter = struct {
    /// The parameter type.
    type: CostCategorySplitChargeRuleParameterType,

    /// The parameter values.
    values: []const []const u8,

    pub const json_field_names = .{
        .type = "Type",
        .values = "Values",
    };
};
