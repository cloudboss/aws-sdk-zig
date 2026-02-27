const MediaInsightsConfiguration = @import("media_insights_configuration.zig").MediaInsightsConfiguration;
const StreamingNotificationTarget = @import("streaming_notification_target.zig").StreamingNotificationTarget;

/// The streaming configuration associated with an Amazon Chime SDK Voice
/// Connector.
/// Specifies whether media streaming is enabled for sending to Amazon Kinesis,
/// and shows the retention
/// period for the Amazon Kinesis data, in hours.
pub const StreamingConfiguration = struct {
    /// The amount of time, in hours, to the Kinesis data.
    data_retention_in_hours: i32,

    /// When true, streaming to Kinesis is off.
    disabled: bool,

    /// The call analytics configuration.
    media_insights_configuration: ?MediaInsightsConfiguration,

    /// The streaming notification targets.
    streaming_notification_targets: ?[]const StreamingNotificationTarget,

    pub const json_field_names = .{
        .data_retention_in_hours = "DataRetentionInHours",
        .disabled = "Disabled",
        .media_insights_configuration = "MediaInsightsConfiguration",
        .streaming_notification_targets = "StreamingNotificationTargets",
    };
};
