const DescribeWorkspacesPoolsFilterName = @import("describe_workspaces_pools_filter_name.zig").DescribeWorkspacesPoolsFilterName;
const DescribeWorkspacesPoolsFilterOperator = @import("describe_workspaces_pools_filter_operator.zig").DescribeWorkspacesPoolsFilterOperator;

/// Describes the filter conditions for WorkSpaces Pools to return.
pub const DescribeWorkspacesPoolsFilter = struct {
    /// The name of the pool to filter.
    name: DescribeWorkspacesPoolsFilterName,

    /// The operator values for filtering WorkSpaces Pools.
    operator: DescribeWorkspacesPoolsFilterOperator,

    /// The values for filtering WorkSpaces Pools.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .values = "Values",
    };
};
