/// An object that contains summary information about a workflow.
pub const FlowTemplateSummary = struct {
    /// The ARN of the workflow.
    arn: ?[]const u8,

    /// The date when the workflow was created.
    created_at: ?i64,

    /// The ID of the workflow.
    id: ?[]const u8,

    /// The revision number of the workflow.
    revision_number: ?i64,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .revision_number = "revisionNumber",
    };
};
