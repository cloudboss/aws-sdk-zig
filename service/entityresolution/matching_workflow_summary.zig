const ResolutionType = @import("resolution_type.zig").ResolutionType;

/// A list of `MatchingWorkflowSummary` objects, each of which contain the
/// fields `workflowName`, `workflowArn`, `resolutionType`, `createdAt`,
/// `updatedAt`.
pub const MatchingWorkflowSummary = struct {
    /// The timestamp of when the workflow was created.
    created_at: i64,

    /// The method that has been specified for data matching, either using matching
    /// provided by Entity Resolution or through a provider service.
    resolution_type: ResolutionType,

    /// The timestamp of when the workflow was last updated.
    updated_at: i64,

    /// The ARN (Amazon Resource Name) that Entity Resolution generated for the
    /// `MatchingWorkflow`.
    workflow_arn: []const u8,

    /// The name of the workflow.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .resolution_type = "resolutionType",
        .updated_at = "updatedAt",
        .workflow_arn = "workflowArn",
        .workflow_name = "workflowName",
    };
};
