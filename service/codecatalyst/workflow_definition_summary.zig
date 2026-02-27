/// Information about a workflow definition.
pub const WorkflowDefinitionSummary = struct {
    /// The path to the workflow definition file stored in the source repository for
    /// the project, including the file name.
    path: []const u8,

    pub const json_field_names = .{
        .path = "path",
    };
};
