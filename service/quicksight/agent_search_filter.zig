const AgentOwnershipFilterAttribute = @import("agent_ownership_filter_attribute.zig").AgentOwnershipFilterAttribute;
const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// A filter to apply when searching agents.
pub const AgentSearchFilter = struct {
    /// The name of the field to filter on.
    name: ?AgentOwnershipFilterAttribute = null,

    /// The comparison operator to use for the filter.
    operator: ?ComparisonOperator = null,

    /// The value to filter on.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .value = "Value",
    };
};
