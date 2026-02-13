const InstancePropertyFilterOperator = @import("instance_property_filter_operator.zig").InstancePropertyFilterOperator;

/// The filters to describe or get information about your managed nodes.
pub const InstancePropertyStringFilter = struct {
    /// The filter key name to describe your managed nodes.
    key: []const u8,

    /// The operator used by the filter call.
    operator: ?InstancePropertyFilterOperator,

    /// The filter key name to describe your managed nodes.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .operator = "Operator",
        .values = "Values",
    };
};
