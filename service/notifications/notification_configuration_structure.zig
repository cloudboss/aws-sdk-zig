const AggregationDuration = @import("aggregation_duration.zig").AggregationDuration;
const NotificationConfigurationStatus = @import("notification_configuration_status.zig").NotificationConfigurationStatus;
const NotificationConfigurationSubtype = @import("notification_configuration_subtype.zig").NotificationConfigurationSubtype;

/// Contains the complete list of fields for a NotificationConfiguration.
pub const NotificationConfigurationStructure = struct {
    /// The aggregation preference of the `NotificationConfiguration`.
    ///
    /// * Values:
    ///
    /// * `LONG`
    ///
    /// * Aggregate notifications for long periods of time (12 hours).
    ///
    /// * `SHORT`
    ///
    /// * Aggregate notifications for short periods of time (5 minutes).
    ///
    /// * `NONE`
    ///
    /// * Don't aggregate notifications.
    aggregation_duration: ?AggregationDuration = null,

    /// The Amazon Resource Name (ARN) of the `NotificationConfiguration` resource.
    arn: []const u8,

    /// The creation time of the `NotificationConfiguration`.
    creation_time: i64,

    /// The description of the `NotificationConfiguration`.
    description: []const u8,

    /// The name of the `NotificationConfiguration`. Supports RFC 3986's unreserved
    /// characters.
    name: []const u8,

    /// The current status of the `NotificationConfiguration`.
    status: NotificationConfigurationStatus,

    /// The subtype of the notification configuration.
    subtype: ?NotificationConfigurationSubtype = null,

    pub const json_field_names = .{
        .aggregation_duration = "aggregationDuration",
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .name = "name",
        .status = "status",
        .subtype = "subtype",
    };
};
