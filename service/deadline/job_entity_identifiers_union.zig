const EnvironmentDetailsIdentifiers = @import("environment_details_identifiers.zig").EnvironmentDetailsIdentifiers;
const JobAttachmentDetailsIdentifiers = @import("job_attachment_details_identifiers.zig").JobAttachmentDetailsIdentifiers;
const JobDetailsIdentifiers = @import("job_details_identifiers.zig").JobDetailsIdentifiers;
const StepDetailsIdentifiers = @import("step_details_identifiers.zig").StepDetailsIdentifiers;

/// The details of a job entity identifier.
pub const JobEntityIdentifiersUnion = union(enum) {
    /// The environment details.
    environment_details: ?EnvironmentDetailsIdentifiers,
    /// The job attachment details.
    job_attachment_details: ?JobAttachmentDetailsIdentifiers,
    /// The job details.
    job_details: ?JobDetailsIdentifiers,
    /// The step details.
    step_details: ?StepDetailsIdentifiers,

    pub const json_field_names = .{
        .environment_details = "environmentDetails",
        .job_attachment_details = "jobAttachmentDetails",
        .job_details = "jobDetails",
        .step_details = "stepDetails",
    };
};
