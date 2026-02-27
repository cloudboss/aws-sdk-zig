/// Represents a workflow type.
pub const WorkflowType = struct {
    /// The name of the workflow type.
    ///
    /// The combination of workflow type name and version must be unique with in a
    /// domain.
    name: []const u8,

    /// The version of the workflow type.
    ///
    /// The combination of workflow type name and version must be unique with in a
    /// domain.
    version: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .version = "version",
    };
};
