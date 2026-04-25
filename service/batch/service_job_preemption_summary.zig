const ServiceJobPreemptedAttempt = @import("service_job_preempted_attempt.zig").ServiceJobPreemptedAttempt;

/// Summarizes the preemptions of the service job. This field appears on a
/// service job
/// when it has been preempted.
pub const ServiceJobPreemptionSummary = struct {
    /// The total number of times the service job has been preempted.
    preempted_attempt_count: ?i32 = null,

    /// A list of the most recent preemption attempts for the service job.
    recent_preempted_attempts: ?[]const ServiceJobPreemptedAttempt = null,

    pub const json_field_names = .{
        .preempted_attempt_count = "preemptedAttemptCount",
        .recent_preempted_attempts = "recentPreemptedAttempts",
    };
};
