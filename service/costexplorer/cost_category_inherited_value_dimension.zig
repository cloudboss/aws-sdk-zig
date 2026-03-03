const CostCategoryInheritedValueDimensionName = @import("cost_category_inherited_value_dimension_name.zig").CostCategoryInheritedValueDimensionName;

/// When you create or update a cost category, you can define the
/// `CostCategoryRule` rule type as `INHERITED_VALUE`. This rule
/// type adds the flexibility to define a rule that dynamically inherits the
/// cost category
/// value from the dimension value that's defined by
/// `CostCategoryInheritedValueDimension`. For example, suppose that you want
/// to dynamically group costs that are based on the value of a specific tag
/// key. First,
/// choose an inherited value rule type, and then choose the tag dimension and
/// specify the
/// tag key to use.
pub const CostCategoryInheritedValueDimension = struct {
    /// The key to extract cost category values.
    dimension_key: ?[]const u8 = null,

    /// The name of the dimension that's used to group costs.
    ///
    /// If you specify `LINKED_ACCOUNT_NAME`, the cost category value is based on
    /// account name. If you specify `TAG`, the cost category value is based on the
    /// value of the specified tag key.
    dimension_name: ?CostCategoryInheritedValueDimensionName = null,

    pub const json_field_names = .{
        .dimension_key = "DimensionKey",
        .dimension_name = "DimensionName",
    };
};
