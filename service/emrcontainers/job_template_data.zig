const aws = @import("aws");

const ParametricConfigurationOverrides = @import("parametric_configuration_overrides.zig").ParametricConfigurationOverrides;
const JobDriver = @import("job_driver.zig").JobDriver;
const TemplateParameterConfiguration = @import("template_parameter_configuration.zig").TemplateParameterConfiguration;

/// The values of StartJobRun API requests used in job runs started using the
/// job
/// template.
pub const JobTemplateData = struct {
    /// The configuration settings that are used to override defaults configuration.
    configuration_overrides: ?ParametricConfigurationOverrides,

    /// The execution role ARN of the job run.
    execution_role_arn: []const u8,

    job_driver: JobDriver,

    /// The tags assigned to jobs started using the job template.
    job_tags: ?[]const aws.map.StringMapEntry,

    /// The configuration of parameters existing in the job template.
    parameter_configuration: ?[]const aws.map.MapEntry(TemplateParameterConfiguration),

    /// The release version of Amazon EMR.
    release_label: []const u8,

    pub const json_field_names = .{
        .configuration_overrides = "configurationOverrides",
        .execution_role_arn = "executionRoleArn",
        .job_driver = "jobDriver",
        .job_tags = "jobTags",
        .parameter_configuration = "parameterConfiguration",
        .release_label = "releaseLabel",
    };
};
