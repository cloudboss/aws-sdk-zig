const PhaseContext = @import("phase_context.zig").PhaseContext;
const StatusType = @import("status_type.zig").StatusType;
const BuildBatchPhaseType = @import("build_batch_phase_type.zig").BuildBatchPhaseType;

/// Contains information about a stage for a batch build.
pub const BuildBatchPhase = struct {
    /// Additional information about the batch build phase. Especially to help
    /// troubleshoot a
    /// failed batch build.
    contexts: ?[]const PhaseContext,

    /// How long, in seconds, between the starting and ending times of the batch
    /// build's
    /// phase.
    duration_in_seconds: ?i64,

    /// When the batch build phase ended, expressed in Unix time format.
    end_time: ?i64,

    /// The current status of the batch build phase. Valid values include:
    ///
    /// **FAILED**
    ///
    /// The build phase failed.
    ///
    /// **FAULT**
    ///
    /// The build phase faulted.
    ///
    /// **IN_PROGRESS**
    ///
    /// The build phase is still in progress.
    ///
    /// **STOPPED**
    ///
    /// The build phase stopped.
    ///
    /// **SUCCEEDED**
    ///
    /// The build phase succeeded.
    ///
    /// **TIMED_OUT**
    ///
    /// The build phase timed out.
    phase_status: ?StatusType,

    /// The name of the batch build phase. Valid values include:
    ///
    /// **COMBINE_ARTIFACTS**
    ///
    /// Build output artifacts are being combined and uploaded to the output
    /// location.
    ///
    /// **DOWNLOAD_BATCHSPEC**
    ///
    /// The batch build specification is being downloaded.
    ///
    /// **FAILED**
    ///
    /// One or more of the builds failed.
    ///
    /// **IN_PROGRESS**
    ///
    /// The batch build is in progress.
    ///
    /// **STOPPED**
    ///
    /// The batch build was stopped.
    ///
    /// **SUBMITTED**
    ///
    /// The btach build has been submitted.
    ///
    /// **SUCCEEDED**
    ///
    /// The batch build succeeded.
    phase_type: ?BuildBatchPhaseType,

    /// When the batch build phase started, expressed in Unix time format.
    start_time: ?i64,

    pub const json_field_names = .{
        .contexts = "contexts",
        .duration_in_seconds = "durationInSeconds",
        .end_time = "endTime",
        .phase_status = "phaseStatus",
        .phase_type = "phaseType",
        .start_time = "startTime",
    };
};
