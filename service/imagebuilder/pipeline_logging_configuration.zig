/// The logging configuration that's defined for pipeline execution.
pub const PipelineLoggingConfiguration = struct {
    /// Specifies the CloudWatch Logs log group name for image build logs.
    /// The log group name can contain alphanumeric characters, hyphens,
    /// underscores, forward slashes, and periods, up to 512 characters.
    /// Log group names not starting with `/aws/imagebuilder/`
    /// require an `executionRole` with CloudWatch Logs write
    /// permissions. If not specified, defaults to
    /// `/aws/imagebuilder/image-name`.
    image_log_group_name: ?[]const u8 = null,

    /// Specifies the CloudWatch Logs log group name for pipeline execution
    /// logs. The log group name can contain alphanumeric characters, hyphens,
    /// underscores, forward slashes, and periods, up to 512 characters.
    /// Log group names not starting with `/aws/imagebuilder/`
    /// require an `executionRole` with CloudWatch Logs write
    /// permissions. If not specified, defaults to
    /// `/aws/imagebuilder/pipeline/pipeline-name`.
    pipeline_log_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_log_group_name = "imageLogGroupName",
        .pipeline_log_group_name = "pipelineLogGroupName",
    };
};
