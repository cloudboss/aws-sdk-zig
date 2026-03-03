const MediaInsightsPipelineConfigurationElement = @import("media_insights_pipeline_configuration_element.zig").MediaInsightsPipelineConfigurationElement;
const RealTimeAlertConfiguration = @import("real_time_alert_configuration.zig").RealTimeAlertConfiguration;

/// A structure that contains the configuration settings for a media insights
/// pipeline.
pub const MediaInsightsPipelineConfiguration = struct {
    /// The time at which the configuration was created.
    created_timestamp: ?i64 = null,

    /// The elements in the configuration.
    elements: ?[]const MediaInsightsPipelineConfigurationElement = null,

    /// The ARN of the configuration.
    media_insights_pipeline_configuration_arn: ?[]const u8 = null,

    /// The ID of the configuration.
    media_insights_pipeline_configuration_id: ?[]const u8 = null,

    /// The name of the configuration.
    media_insights_pipeline_configuration_name: ?[]const u8 = null,

    /// Lists the rules that trigger a real-time alert.
    real_time_alert_configuration: ?RealTimeAlertConfiguration = null,

    /// The ARN of the role used by the service to access Amazon Web Services
    /// resources.
    resource_access_role_arn: ?[]const u8 = null,

    /// The time at which the configuration was last updated.
    updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .elements = "Elements",
        .media_insights_pipeline_configuration_arn = "MediaInsightsPipelineConfigurationArn",
        .media_insights_pipeline_configuration_id = "MediaInsightsPipelineConfigurationId",
        .media_insights_pipeline_configuration_name = "MediaInsightsPipelineConfigurationName",
        .real_time_alert_configuration = "RealTimeAlertConfiguration",
        .resource_access_role_arn = "ResourceAccessRoleArn",
        .updated_timestamp = "UpdatedTimestamp",
    };
};
