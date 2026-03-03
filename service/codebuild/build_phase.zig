const PhaseContext = @import("phase_context.zig").PhaseContext;
const StatusType = @import("status_type.zig").StatusType;
const BuildPhaseType = @import("build_phase_type.zig").BuildPhaseType;

/// Information about a stage for a build.
pub const BuildPhase = struct {
    /// Additional information about a build phase, especially to help troubleshoot
    /// a failed
    /// build.
    contexts: ?[]const PhaseContext = null,

    /// How long, in seconds, between the starting and ending times of the build's
    /// phase.
    duration_in_seconds: ?i64 = null,

    /// When the build phase ended, expressed in Unix time format.
    end_time: ?i64 = null,

    /// The current status of the build phase. Valid values include:
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
    phase_status: ?StatusType = null,

    /// The name of the build phase. Valid values include:
    ///
    /// **BUILD**
    ///
    /// Core build activities typically occur in this build phase.
    ///
    /// **COMPLETED**
    ///
    /// The build has been completed.
    ///
    /// **DOWNLOAD_SOURCE**
    ///
    /// Source code is being downloaded in this build phase.
    ///
    /// **FINALIZING**
    ///
    /// The build process is completing in this build phase.
    ///
    /// **INSTALL**
    ///
    /// Installation activities typically occur in this build phase.
    ///
    /// **POST_BUILD**
    ///
    /// Post-build activities typically occur in this build phase.
    ///
    /// **PRE_BUILD**
    ///
    /// Pre-build activities typically occur in this build phase.
    ///
    /// **PROVISIONING**
    ///
    /// The build environment is being set up.
    ///
    /// **QUEUED**
    ///
    /// The build has been submitted and is queued behind other submitted
    /// builds.
    ///
    /// **SUBMITTED**
    ///
    /// The build has been submitted.
    ///
    /// **UPLOAD_ARTIFACTS**
    ///
    /// Build output artifacts are being uploaded to the output location.
    phase_type: ?BuildPhaseType = null,

    /// When the build phase started, expressed in Unix time format.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .contexts = "contexts",
        .duration_in_seconds = "durationInSeconds",
        .end_time = "endTime",
        .phase_status = "phaseStatus",
        .phase_type = "phaseType",
        .start_time = "startTime",
    };
};
