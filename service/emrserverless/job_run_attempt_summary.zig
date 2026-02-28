const JobRunMode = @import("job_run_mode.zig").JobRunMode;
const JobRunState = @import("job_run_state.zig").JobRunState;

/// The summary of attributes associated with a job run attempt.
pub const JobRunAttemptSummary = struct {
    /// The ID of the application the job is running on.
    application_id: []const u8,

    /// The Amazon Resource Name (ARN) of the job run.
    arn: []const u8,

    /// The attempt number of the job run execution.
    attempt: ?i32,

    /// The date and time when the job run attempt was created.
    created_at: i64,

    /// The user who created the job run.
    created_by: []const u8,

    /// The Amazon Resource Name (ARN) of the execution role of the job run..
    execution_role: []const u8,

    /// The ID of the job run attempt.
    id: []const u8,

    /// The date and time of when the job run was created.
    job_created_at: i64,

    /// The mode of the job run attempt.
    mode: ?JobRunMode,

    /// The name of the job run attempt.
    name: ?[]const u8,

    /// The Amazon EMR release label of the job run attempt.
    release_label: []const u8,

    /// The state of the job run attempt.
    state: JobRunState,

    /// The state details of the job run attempt.
    state_details: []const u8,

    /// The type of the job run, such as Spark or Hive.
    type: ?[]const u8,

    /// The date and time of when the job run attempt was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .arn = "arn",
        .attempt = "attempt",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .execution_role = "executionRole",
        .id = "id",
        .job_created_at = "jobCreatedAt",
        .mode = "mode",
        .name = "name",
        .release_label = "releaseLabel",
        .state = "state",
        .state_details = "stateDetails",
        .type = "type",
        .updated_at = "updatedAt",
    };
};
