const InstanceOnboardingJobFailureCode = @import("instance_onboarding_job_failure_code.zig").InstanceOnboardingJobFailureCode;
const InstanceOnboardingJobStatusCode = @import("instance_onboarding_job_status_code.zig").InstanceOnboardingJobStatusCode;

/// Instance onboarding job status object
pub const InstanceOnboardingJobStatus = struct {
    connect_instance_id: []const u8,

    failure_code: ?InstanceOnboardingJobFailureCode = null,

    status: InstanceOnboardingJobStatusCode,

    pub const json_field_names = .{
        .connect_instance_id = "connectInstanceId",
        .failure_code = "failureCode",
        .status = "status",
    };
};
