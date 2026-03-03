const AggregationEventType = @import("aggregation_event_type.zig").AggregationEventType;
const AggregationSummary = @import("aggregation_summary.zig").AggregationSummary;
const NotificationEventSummary = @import("notification_event_summary.zig").NotificationEventSummary;

/// Describes a short summary of a `NotificationEvent`. This is only used when
/// listing notification events.
pub const NotificationEventOverview = struct {
    /// The ARN of the `aggregatedNotificationEventArn` to match.
    aggregate_notification_event_arn: ?[]const u8 = null,

    /// The `NotificationConfiguration`'s aggregation type.
    ///
    /// * Values:
    ///
    /// * `AGGREGATE`
    ///
    /// * The notification event is an aggregate notification. Aggregate
    ///   notifications summarize grouped events over a specified time period.
    ///
    /// * `CHILD`
    ///
    /// * Some `EventRules` are `ACTIVE` and some are `INACTIVE`. Any call can be
    ///   run.
    ///
    /// * `NONE`
    ///
    /// * The notification isn't aggregated.
    aggregation_event_type: ?AggregationEventType = null,

    /// Provides an aggregated summary data for notification events.
    aggregation_summary: ?AggregationSummary = null,

    /// The Amazon Resource Name (ARN) of the resource.
    arn: []const u8,

    /// The creation time of the `NotificationEvent`.
    creation_time: i64,

    /// The ARN of the `NotificationConfiguration`.
    notification_configuration_arn: []const u8,

    /// Refers to a `NotificationEventSummary` object.
    ///
    /// Similar in structure to `content` in the `GetNotificationEvent` response.
    notification_event: NotificationEventSummary,

    /// The unique identifier of the organizational unit in the notification event
    /// overview.
    organizational_unit_id: ?[]const u8 = null,

    /// The account name containing the `NotificationHub`.
    related_account: []const u8,

    pub const json_field_names = .{
        .aggregate_notification_event_arn = "aggregateNotificationEventArn",
        .aggregation_event_type = "aggregationEventType",
        .aggregation_summary = "aggregationSummary",
        .arn = "arn",
        .creation_time = "creationTime",
        .notification_configuration_arn = "notificationConfigurationArn",
        .notification_event = "notificationEvent",
        .organizational_unit_id = "organizationalUnitId",
        .related_account = "relatedAccount",
    };
};
