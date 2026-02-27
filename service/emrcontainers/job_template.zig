const aws = @import("aws");

const JobTemplateData = @import("job_template_data.zig").JobTemplateData;

/// This entity describes a job template. Job template stores values of
/// StartJobRun API
/// request in a template and can be used to start a job run. Job template
/// allows two use
/// cases: avoid repeating recurring StartJobRun API request values, enforcing
/// certain values
/// in StartJobRun API request.
pub const JobTemplate = struct {
    /// The ARN of the job template.
    arn: ?[]const u8,

    /// The date and time when the job template was created.
    created_at: ?i64,

    /// The user who created the job template.
    created_by: ?[]const u8,

    /// The error message in case the decryption of job template fails.
    decryption_error: ?[]const u8,

    /// The ID of the job template.
    id: ?[]const u8,

    /// The job template data which holds values of StartJobRun API request.
    job_template_data: JobTemplateData,

    /// The KMS key ARN used to encrypt the job template.
    kms_key_arn: ?[]const u8,

    /// The name of the job template.
    name: ?[]const u8,

    /// The tags assigned to the job template.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .decryption_error = "decryptionError",
        .id = "id",
        .job_template_data = "jobTemplateData",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .tags = "tags",
    };
};
