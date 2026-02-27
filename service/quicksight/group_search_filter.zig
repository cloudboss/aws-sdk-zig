const GroupFilterAttribute = @import("group_filter_attribute.zig").GroupFilterAttribute;
const GroupFilterOperator = @import("group_filter_operator.zig").GroupFilterOperator;

/// A `GroupSearchFilter` object that you want to apply to your search.
pub const GroupSearchFilter = struct {
    /// The name of the value that you want to use as a filter, for example `"Name":
    /// "GROUP_NAME"`. Currently, the only supported name is
    /// `GROUP_NAME`.
    name: GroupFilterAttribute,

    /// The comparison operator that you want to use as a filter, for example
    /// `"Operator":
    /// "StartsWith"`. Currently, the only supported operator is
    /// `StartsWith`.
    operator: GroupFilterOperator,

    /// The value of the named item, in this case `GROUP_NAME`, that you want to use
    /// as a filter.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .value = "Value",
    };
};
