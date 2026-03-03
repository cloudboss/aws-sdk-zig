const CompletedStatus = @import("completed_status.zig").CompletedStatus;
const TaskRunManifestPropertiesRequest = @import("task_run_manifest_properties_request.zig").TaskRunManifestPropertiesRequest;

/// The updated session action information as it relates to completion and
/// progress of the session.
pub const UpdatedSessionActionInfo = struct {
    /// The status of the session upon completion.
    completed_status: ?CompletedStatus = null,

    /// The date and time the resource ended running.
    ended_at: ?i64 = null,

    /// A list of output manifest properties reported by the worker agent, with each
    /// entry corresponding to a manifest property in the job.
    manifests: ?[]const TaskRunManifestPropertiesRequest = null,

    /// The process exit code. The default Deadline Cloud worker agent converts
    /// unsigned 32-bit exit codes to signed 32-bit exit codes.
    process_exit_code: ?i32 = null,

    /// A message to indicate the progress of the updated session action.
    progress_message: ?[]const u8 = null,

    /// The percentage completed.
    progress_percent: ?f32 = null,

    /// The date and time the resource started running.
    started_at: ?i64 = null,

    /// The updated time.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .completed_status = "completedStatus",
        .ended_at = "endedAt",
        .manifests = "manifests",
        .process_exit_code = "processExitCode",
        .progress_message = "progressMessage",
        .progress_percent = "progressPercent",
        .started_at = "startedAt",
        .updated_at = "updatedAt",
    };
};
