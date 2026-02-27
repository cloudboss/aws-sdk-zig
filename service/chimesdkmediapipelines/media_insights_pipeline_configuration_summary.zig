/// A summary of the media insights pipeline configuration.
pub const MediaInsightsPipelineConfigurationSummary = struct {
    /// The ARN of the media insights pipeline configuration.
    media_insights_pipeline_configuration_arn: ?[]const u8,

    /// The ID of the media insights pipeline configuration.
    media_insights_pipeline_configuration_id: ?[]const u8,

    /// The name of the media insights pipeline configuration.
    media_insights_pipeline_configuration_name: ?[]const u8,

    pub const json_field_names = .{
        .media_insights_pipeline_configuration_arn = "MediaInsightsPipelineConfigurationArn",
        .media_insights_pipeline_configuration_id = "MediaInsightsPipelineConfigurationId",
        .media_insights_pipeline_configuration_name = "MediaInsightsPipelineConfigurationName",
    };
};
