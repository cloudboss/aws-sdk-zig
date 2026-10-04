const ExperimentRunStatus = @import("experiment_run_status.zig").ExperimentRunStatus;

/// Summary information about an experiment run.
pub const ExperimentRunSummary = struct {
    /// A description of the experiment run.
    description: ?[]const u8 = null,

    /// The date and time the experiment run ended, in ISO 8601 format.
    ended_at: ?i64 = null,

    /// The experiment definition ID.
    experiment_definition_id: ?[]const u8 = null,

    /// The experiment run number.
    run: i32 = 0,

    /// The date and time the experiment run started, in ISO 8601 format.
    started_at: ?i64 = null,

    /// The current status of the experiment run.
    status: ?ExperimentRunStatus = null,

    /// The date and time the experiment run was last updated, in ISO 8601 format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .description = "Description",
        .ended_at = "EndedAt",
        .experiment_definition_id = "ExperimentDefinitionId",
        .run = "Run",
        .started_at = "StartedAt",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
