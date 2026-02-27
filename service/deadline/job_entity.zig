const EnvironmentDetailsEntity = @import("environment_details_entity.zig").EnvironmentDetailsEntity;
const JobAttachmentDetailsEntity = @import("job_attachment_details_entity.zig").JobAttachmentDetailsEntity;
const JobDetailsEntity = @import("job_details_entity.zig").JobDetailsEntity;
const StepDetailsEntity = @import("step_details_entity.zig").StepDetailsEntity;

/// The details of a job entity.
pub const JobEntity = union(enum) {
    /// The environment details for the job entity.
    environment_details: ?EnvironmentDetailsEntity,
    /// The job attachment details.
    job_attachment_details: ?JobAttachmentDetailsEntity,
    /// The job details.
    job_details: ?JobDetailsEntity,
    /// The step details.
    step_details: ?StepDetailsEntity,

    pub const json_field_names = .{
        .environment_details = "environmentDetails",
        .job_attachment_details = "jobAttachmentDetails",
        .job_details = "jobDetails",
        .step_details = "stepDetails",
    };
};
