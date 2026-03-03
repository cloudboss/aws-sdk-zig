const aws = @import("aws");

const ProcessingInstanceType = @import("processing_instance_type.zig").ProcessingInstanceType;

/// Configuration information for profiling rules.
pub const ProfilerRuleConfiguration = struct {
    /// The instance type to deploy a custom rule for profiling a training job.
    instance_type: ?ProcessingInstanceType = null,

    /// Path to local storage location for output of rules. Defaults to
    /// `/opt/ml/processing/output/rule/`.
    local_path: ?[]const u8 = null,

    /// The name of the rule configuration. It must be unique relative to other rule
    /// configuration names.
    rule_configuration_name: []const u8,

    /// The Amazon Elastic Container Registry Image for the managed rule evaluation.
    rule_evaluator_image: []const u8,

    /// Runtime configuration for rule container.
    rule_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Path to Amazon S3 storage location for rules.
    s3_output_path: ?[]const u8 = null,

    /// The size, in GB, of the ML storage volume attached to the processing
    /// instance.
    volume_size_in_gb: ?i32 = null,

    pub const json_field_names = .{
        .instance_type = "InstanceType",
        .local_path = "LocalPath",
        .rule_configuration_name = "RuleConfigurationName",
        .rule_evaluator_image = "RuleEvaluatorImage",
        .rule_parameters = "RuleParameters",
        .s3_output_path = "S3OutputPath",
        .volume_size_in_gb = "VolumeSizeInGB",
    };
};
