const DescribeWorkspaceDirectoriesFilterName = @import("describe_workspace_directories_filter_name.zig").DescribeWorkspaceDirectoriesFilterName;

/// Describes the filter conditions for the WorkSpaces to return.
pub const DescribeWorkspaceDirectoriesFilter = struct {
    /// The name of the WorkSpaces to filter.
    name: DescribeWorkspaceDirectoriesFilterName,

    /// The values for filtering WorkSpaces
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
