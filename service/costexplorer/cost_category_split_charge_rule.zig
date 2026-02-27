const CostCategorySplitChargeMethod = @import("cost_category_split_charge_method.zig").CostCategorySplitChargeMethod;
const CostCategorySplitChargeRuleParameter = @import("cost_category_split_charge_rule_parameter.zig").CostCategorySplitChargeRuleParameter;

/// Use the split charge rule to split the cost of one cost category value
/// across several
/// other target values.
pub const CostCategorySplitChargeRule = struct {
    /// The method that's used to define how to split your source costs across your
    /// targets.
    ///
    /// `Proportional` - Allocates charges across your targets based on the
    /// proportional weighted cost of each target.
    ///
    /// `Fixed` - Allocates charges across your targets based on your defined
    /// allocation percentage.
    ///
    /// >`Even` - Allocates costs evenly across all targets.
    method: CostCategorySplitChargeMethod,

    /// The parameters for a split charge method. This is only required for the
    /// `FIXED` method.
    parameters: ?[]const CostCategorySplitChargeRuleParameter,

    /// The cost category value that you want to split. That value can't be used as
    /// a source
    /// or a target in other split charge rules. To indicate uncategorized costs,
    /// you can use an
    /// empty string as the source.
    source: []const u8,

    /// The cost category values that you want to split costs across. These values
    /// can't be
    /// used as a source in other split charge rules.
    targets: []const []const u8,

    pub const json_field_names = .{
        .method = "Method",
        .parameters = "Parameters",
        .source = "Source",
        .targets = "Targets",
    };
};
