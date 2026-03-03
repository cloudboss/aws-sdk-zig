const JobRunMode = @import("job_run_mode.zig").JobRunMode;
const JobRunState = @import("job_run_state.zig").JobRunState;

/// The summary of attributes associated with a job run.
pub const JobRunSummary = struct {
    /// The ID of the application the job is running on.
    application_id: []const u8,

    /// The ARN of the job run.
    arn: []const u8,

    /// The attempt number of the job run execution.
    attempt: ?i32 = null,

    /// The date and time of when the job run attempt was created.
    attempt_created_at: ?i64 = null,

    /// The date and time of when the job run attempt was last updated.
    attempt_updated_at: ?i64 = null,

    /// The date and time when the job run was created.
    created_at: i64,

    /// The user who created the job run.
    created_by: []const u8,

    /// The execution role ARN of the job run.
    execution_role: []const u8,

    /// The ID of the job run.
    id: []const u8,

    /// The mode of the job run.
    mode: ?JobRunMode = null,

    /// The optional job run name. This doesn't have to be unique.
    name: ?[]const u8 = null,

    /// The Amazon EMR release associated with the application your job is running
    /// on.
    release_label: []const u8,

    /// The state of the job run.
    state: JobRunState,

    /// The state details of the job run.
    state_details: []const u8,

    /// The type of job run, such as Spark or Hive.
    @"type": ?[]const u8 = null,

    /// The date and time when the job run was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .arn = "arn",
        .attempt = "attempt",
        .attempt_created_at = "attemptCreatedAt",
        .attempt_updated_at = "attemptUpdatedAt",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .execution_role = "executionRole",
        .id = "id",
        .mode = "mode",
        .name = "name",
        .release_label = "releaseLabel",
        .state = "state",
        .state_details = "stateDetails",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};
