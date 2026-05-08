const NotebookRunStatus = @import("notebook_run_status.zig").NotebookRunStatus;
const TriggerSource = @import("trigger_source.zig").TriggerSource;

/// The summary of a notebook run in Amazon DataZone.
pub const NotebookRunSummary = struct {
    /// The timestamp of when the notebook run completed.
    completed_at: ?i64 = null,

    /// The timestamp of when the notebook run was created.
    created_at: ?i64 = null,

    /// The identifier of the user who created the notebook run.
    created_by: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain.
    domain_id: []const u8,

    /// The identifier of the notebook run.
    id: []const u8,

    /// The identifier of the notebook.
    notebook_id: []const u8,

    /// The identifier of the project that owns the notebook run.
    owning_project_id: []const u8,

    /// The identifier of the schedule associated with the notebook run.
    schedule_id: ?[]const u8 = null,

    /// The timestamp of when the notebook run started executing.
    started_at: ?i64 = null,

    /// The status of the notebook run.
    status: NotebookRunStatus,

    /// The source that triggered the notebook run.
    trigger_source: ?TriggerSource = null,

    /// The timestamp of when the notebook run was last updated.
    updated_at: ?i64 = null,

    /// The identifier of the user who last updated the notebook run.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .completed_at = "completedAt",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .id = "id",
        .notebook_id = "notebookId",
        .owning_project_id = "owningProjectId",
        .schedule_id = "scheduleId",
        .started_at = "startedAt",
        .status = "status",
        .trigger_source = "triggerSource",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};
