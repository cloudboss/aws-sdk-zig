const CostCategoryProcessingStatus = @import("cost_category_processing_status.zig").CostCategoryProcessingStatus;
const CostCategoryRule = @import("cost_category_rule.zig").CostCategoryRule;
const CostCategoryRuleVersion = @import("cost_category_rule_version.zig").CostCategoryRuleVersion;
const CostCategorySplitChargeRule = @import("cost_category_split_charge_rule.zig").CostCategorySplitChargeRule;

/// The structure of Cost Categories. This includes detailed metadata and the
/// set of rules
/// for the `CostCategory` object.
pub const CostCategory = struct {
    /// The unique identifier for your cost category.
    cost_category_arn: []const u8,

    default_value: ?[]const u8,

    /// The effective end date of your cost category.
    effective_end: ?[]const u8,

    /// The effective start date of your cost category.
    effective_start: []const u8,

    name: []const u8,

    /// The list of processing statuses for Cost Management products for a specific
    /// cost
    /// category.
    processing_status: ?[]const CostCategoryProcessingStatus,

    /// The rules are processed in order. If there are multiple rules that match the
    /// line
    /// item, then the first rule to match is used to determine that cost category
    /// value.
    rules: []const CostCategoryRule,

    rule_version: CostCategoryRuleVersion,

    /// The split charge rules that are used to allocate your charges between your
    /// cost category values.
    split_charge_rules: ?[]const CostCategorySplitChargeRule,

    pub const json_field_names = .{
        .cost_category_arn = "CostCategoryArn",
        .default_value = "DefaultValue",
        .effective_end = "EffectiveEnd",
        .effective_start = "EffectiveStart",
        .name = "Name",
        .processing_status = "ProcessingStatus",
        .rules = "Rules",
        .rule_version = "RuleVersion",
        .split_charge_rules = "SplitChargeRules",
    };
};
