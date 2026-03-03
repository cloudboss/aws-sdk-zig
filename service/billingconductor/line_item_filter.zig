const LineItemFilterAttributeName = @import("line_item_filter_attribute_name.zig").LineItemFilterAttributeName;
const MatchOption = @import("match_option.zig").MatchOption;
const LineItemFilterValue = @import("line_item_filter_value.zig").LineItemFilterValue;

/// A representation of the line item filter for your custom line item. You can
/// use line item filters to include or exclude specific resource values from
/// the billing group's total cost. For example, if you create a custom line
/// item and you want to filter out a value, such as Savings Plans discounts,
/// you can update `LineItemFilter` to exclude it.
pub const LineItemFilter = struct {
    /// The attribute of the line item filter. This specifies what attribute that
    /// you can filter on.
    attribute: LineItemFilterAttributeName,

    /// The values of the line item filter. This specifies the values to filter on.
    attribute_values: ?[]const []const u8 = null,

    /// The match criteria of the line item filter. This parameter specifies whether
    /// not to include the resource value from the billing group total cost.
    match_option: MatchOption,

    /// The values of the line item filter. This specifies the values to filter on.
    /// Currently, you can only exclude Savings Plans discounts.
    values: []const LineItemFilterValue = &.{},

    pub const json_field_names = .{
        .attribute = "Attribute",
        .attribute_values = "AttributeValues",
        .match_option = "MatchOption",
        .values = "Values",
    };
};
