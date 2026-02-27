const DQStopJobOnFailureTiming = @import("dq_stop_job_on_failure_timing.zig").DQStopJobOnFailureTiming;

/// Options to configure how your job will stop if your data quality evaluation
/// fails.
pub const DQStopJobOnFailureOptions = struct {
    /// When to stop job if your data quality evaluation fails. Options are
    /// Immediate or AfterDataLoad.
    stop_job_on_failure_timing: ?DQStopJobOnFailureTiming,

    pub const json_field_names = .{
        .stop_job_on_failure_timing = "StopJobOnFailureTiming",
    };
};
