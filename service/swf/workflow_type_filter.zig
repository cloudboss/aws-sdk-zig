/// Used to filter workflow execution query results by type. Each parameter, if
/// specified, defines a rule that must be satisfied by each returned result.
pub const WorkflowTypeFilter = struct {
    /// Name of the workflow type.
    name: []const u8,

    /// Version of the workflow type.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .version = "version",
    };
};
