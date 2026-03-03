const AggregationEventType = @import("aggregation_event_type.zig").AggregationEventType;
const AggregationSummary = @import("aggregation_summary.zig").AggregationSummary;
const ManagedNotificationEventSummary = @import("managed_notification_event_summary.zig").ManagedNotificationEventSummary;

/// Describes an overview and metadata for a ManagedNotificationEvent.
pub const ManagedNotificationEventOverview = struct {
    /// The list of the regions where the aggregated notifications in this
    /// `NotificationEvent` originated.
    aggregated_notification_regions: ?[]const []const u8 = null,

    /// The notifications aggregation type.
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

    aggregation_summary: ?AggregationSummary = null,

    /// The Amazon Resource Name (ARN) of the ManagedNotificationEvent.
    arn: []const u8,

    /// The creation time of the `ManagedNotificationEvent`.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the `ManagedNotificationConfiguration`.
    managed_notification_configuration_arn: []const u8,

    notification_event: ManagedNotificationEventSummary,

    /// The Organizational Unit Id that an Amazon Web Services account belongs to.
    organizational_unit_id: ?[]const u8 = null,

    /// The account that related to the `ManagedNotificationEvent`.
    related_account: []const u8,

    pub const json_field_names = .{
        .aggregated_notification_regions = "aggregatedNotificationRegions",
        .aggregation_event_type = "aggregationEventType",
        .aggregation_summary = "aggregationSummary",
        .arn = "arn",
        .creation_time = "creationTime",
        .managed_notification_configuration_arn = "managedNotificationConfigurationArn",
        .notification_event = "notificationEvent",
        .organizational_unit_id = "organizationalUnitId",
        .related_account = "relatedAccount",
    };
};
