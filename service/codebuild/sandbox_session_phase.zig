const PhaseContext = @import("phase_context.zig").PhaseContext;
const StatusType = @import("status_type.zig").StatusType;

/// Contains information about the sandbox phase.
pub const SandboxSessionPhase = struct {
    /// An array of `PhaseContext` objects.
    contexts: ?[]const PhaseContext = null,

    /// How long, in seconds, between the starting and ending times of the sandbox's
    /// phase.
    duration_in_seconds: ?i64 = null,

    /// When the sandbox phase ended, expressed in Unix time format.
    end_time: ?i64 = null,

    /// The current status of the sandbox phase. Valid values include:
    ///
    /// **FAILED**
    ///
    /// The sandbox phase failed.
    ///
    /// **FAULT**
    ///
    /// The sandbox phase faulted.
    ///
    /// **IN_PROGRESS**
    ///
    /// The sandbox phase is still in progress.
    ///
    /// **STOPPED**
    ///
    /// The sandbox phase stopped.
    ///
    /// **SUCCEEDED**
    ///
    /// The sandbox phase succeeded.
    ///
    /// **TIMED_OUT**
    ///
    /// The sandbox phase timed out.
    phase_status: ?StatusType = null,

    /// The name of the sandbox phase.
    phase_type: ?[]const u8 = null,

    /// When the sandbox phase started, expressed in Unix time format.
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
