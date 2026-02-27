const EnvironmentDetailsError = @import("environment_details_error.zig").EnvironmentDetailsError;
const JobAttachmentDetailsError = @import("job_attachment_details_error.zig").JobAttachmentDetailsError;
const JobDetailsError = @import("job_details_error.zig").JobDetailsError;
const StepDetailsError = @import("step_details_error.zig").StepDetailsError;

/// The error for the job entity.
pub const GetJobEntityError = union(enum) {
    /// The environment details for the failed job entity.
    environment_details: ?EnvironmentDetailsError,
    /// The job attachment details for the failed job entity.
    job_attachment_details: ?JobAttachmentDetailsError,
    /// The job details for the failed job entity.
    job_details: ?JobDetailsError,
    /// The step details for the failed job entity.
    step_details: ?StepDetailsError,

    pub const json_field_names = .{
        .environment_details = "environmentDetails",
        .job_attachment_details = "jobAttachmentDetails",
        .job_details = "jobDetails",
        .step_details = "stepDetails",
    };
};
