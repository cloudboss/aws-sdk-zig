const JobStepRestartMarker = @import("job_step_restart_marker.zig").JobStepRestartMarker;

/// An identifier for the `StartBatchJob` API to show that it is a restart
/// operation.
pub const RestartBatchJobIdentifier = struct {
    /// The `executionId` from the `StartBatchJob` response when the job ran for the
    /// first time.
    execution_id: []const u8,

    /// The step/procedure step information for a restart batch job operation.
    job_step_restart_marker: JobStepRestartMarker,

    pub const json_field_names = .{
        .execution_id = "executionId",
        .job_step_restart_marker = "jobStepRestartMarker",
    };
};
