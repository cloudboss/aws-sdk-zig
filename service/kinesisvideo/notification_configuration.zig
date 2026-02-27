const NotificationDestinationConfig = @import("notification_destination_config.zig").NotificationDestinationConfig;
const ConfigurationStatus = @import("configuration_status.zig").ConfigurationStatus;

/// Use this API to configure Amazon Simple Notification Service (Amazon SNS)
/// notifications for when fragments become available in a stream. If this
/// parameter is
/// null, the configuration will be deleted from the stream.
///
/// See [Notifications in Kinesis
/// Video
/// Streams](https://docs.aws.amazon.com/kinesisvideostreams/latest/dg/notifications.html) for more information.
pub const NotificationConfiguration = struct {
    /// The destination information required to deliver a notification to a
    /// customer.
    destination_config: NotificationDestinationConfig,

    /// Indicates if a notification configuration is enabled or disabled.
    status: ConfigurationStatus,

    pub const json_field_names = .{
        .destination_config = "DestinationConfig",
        .status = "Status",
    };
};
