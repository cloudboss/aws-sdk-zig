const aws = @import("aws");

const JobAttachmentSettings = @import("job_attachment_settings.zig").JobAttachmentSettings;
const JobRunAsUser = @import("job_run_as_user.zig").JobRunAsUser;
const JobParameter = @import("job_parameter.zig").JobParameter;
const PathMappingRule = @import("path_mapping_rule.zig").PathMappingRule;

/// The job details for a specific job.
pub const JobDetailsEntity = struct {
    /// The job attachment settings.
    job_attachment_settings: ?JobAttachmentSettings,

    /// The job ID.
    job_id: []const u8,

    /// The user name and group that the job uses when run.
    job_run_as_user: ?JobRunAsUser,

    /// The log group name.
    log_group_name: []const u8,

    /// The parameters.
    parameters: ?[]const aws.map.MapEntry(JobParameter),

    /// The path mapping rules.
    path_mapping_rules: ?[]const PathMappingRule,

    /// The queue role ARN.
    queue_role_arn: ?[]const u8,

    /// The schema version.
    schema_version: []const u8,

    pub const json_field_names = .{
        .job_attachment_settings = "jobAttachmentSettings",
        .job_id = "jobId",
        .job_run_as_user = "jobRunAsUser",
        .log_group_name = "logGroupName",
        .parameters = "parameters",
        .path_mapping_rules = "pathMappingRules",
        .queue_role_arn = "queueRoleArn",
        .schema_version = "schemaVersion",
    };
};
