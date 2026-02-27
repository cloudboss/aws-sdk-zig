/// The migration workflow template used as the source for the new template.
pub const TemplateSource = union(enum) {
    /// The ID of the workflow from the source migration workflow template.
    workflow_id: ?[]const u8,

    pub const json_field_names = .{
        .workflow_id = "workflowId",
    };
};
