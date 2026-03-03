const CostCategoryInheritedValueDimension = @import("cost_category_inherited_value_dimension.zig").CostCategoryInheritedValueDimension;
const Expression = @import("expression.zig").Expression;
const CostCategoryRuleType = @import("cost_category_rule_type.zig").CostCategoryRuleType;

/// Rules are processed in order. If there are multiple rules that match the
/// line item,
/// then the first rule to match is used to determine that cost category value.
pub const CostCategoryRule = struct {
    /// The value the line item is categorized as if the line item contains the
    /// matched
    /// dimension.
    inherited_value: ?CostCategoryInheritedValueDimension = null,

    /// An
    /// [Expression](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_Expression.html)
    /// object used to categorize costs. This supports dimensions, tags, and nested
    /// expressions.
    /// Currently the only dimensions supported are `LINKED_ACCOUNT`,
    ///
    /// `SERVICE_CODE`, `RECORD_TYPE`, `LINKED_ACCOUNT_NAME`, `REGION`, and
    /// `USAGE_TYPE`.
    ///
    /// `RECORD_TYPE` is a dimension used for Cost Explorer APIs, and is also
    /// supported for cost category expressions. This dimension uses different
    /// terms, depending
    /// on whether you're using the console or API/JSON editor. For a detailed
    /// comparison, see
    /// [Term
    /// Comparisons](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/manage-cost-categories.html#cost-categories-terms) in the *Billing and Cost Management User
    /// Guide*.
    rule: ?Expression = null,

    /// You can define the `CostCategoryRule` rule type as either
    /// `REGULAR` or `INHERITED_VALUE`. The
    /// `INHERITED_VALUE` rule type adds the flexibility to define a rule that
    /// dynamically inherits the cost category value. This value is from the
    /// dimension value
    /// that's defined by `CostCategoryInheritedValueDimension`. For example,
    /// suppose
    /// that you want to costs to be dynamically grouped based on the value of a
    /// specific tag
    /// key. First, choose an inherited value rule type, and then choose the tag
    /// dimension and
    /// specify the tag key to use.
    @"type": ?CostCategoryRuleType = null,

    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .inherited_value = "InheritedValue",
        .rule = "Rule",
        .@"type" = "Type",
        .value = "Value",
    };
};
