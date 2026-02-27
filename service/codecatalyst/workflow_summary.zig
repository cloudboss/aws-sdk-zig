const WorkflowDefinitionSummary = @import("workflow_definition_summary.zig").WorkflowDefinitionSummary;
const WorkflowRunMode = @import("workflow_run_mode.zig").WorkflowRunMode;
const WorkflowStatus = @import("workflow_status.zig").WorkflowStatus;

/// Information about a workflow.
pub const WorkflowSummary = struct {
    /// The date and time the workflow was created, in coordinated universal time
    /// (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6)
    created_time: i64,

    /// Information about the workflow definition file.
    definition: WorkflowDefinitionSummary,

    /// The system-generated unique ID of a workflow.
    id: []const u8,

    /// The date and time the workflow was last updated, in coordinated universal
    /// time (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6)
    last_updated_time: i64,

    /// The name of the workflow.
    name: []const u8,

    /// The run mode of the workflow.
    run_mode: WorkflowRunMode,

    /// The name of the branch of the source repository where the workflow
    /// definition file is stored.
    source_branch_name: []const u8,

    /// The name of the source repository where the workflow definition file is
    /// stored.
    source_repository_name: []const u8,

    /// The status of the workflow.
    status: WorkflowStatus,

    pub const json_field_names = .{
        .created_time = "createdTime",
        .definition = "definition",
        .id = "id",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
        .run_mode = "runMode",
        .source_branch_name = "sourceBranchName",
        .source_repository_name = "sourceRepositoryName",
        .status = "status",
    };
};
