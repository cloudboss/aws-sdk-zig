/// Enumeration of the possible states for instance onboarding job
pub const InstanceOnboardingJobStatusCode = enum {
    in_progress,
    succeeded,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
