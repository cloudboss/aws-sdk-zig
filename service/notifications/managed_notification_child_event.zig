const aws = @import("aws");

const AggregationDetail = @import("aggregation_detail.zig").AggregationDetail;
const EventStatus = @import("event_status.zig").EventStatus;
const MessageComponents = @import("message_components.zig").MessageComponents;
const NotificationType = @import("notification_type.zig").NotificationType;
const SchemaVersion = @import("schema_version.zig").SchemaVersion;
const TextPartValue = @import("text_part_value.zig").TextPartValue;

/// A ManagedNotificationChildEvent is a notification-focused representation of
/// an event. They contain semantic information used to create aggregated or
/// non-aggregated end-user notifications.
pub const ManagedNotificationChildEvent = struct {
    /// The Amazon Resource Name (ARN) of the ManagedNotificationEvent that is
    /// associated with this Managed Notification Child Event.
    aggregate_managed_notification_event_arn: []const u8,

    /// Provides detailed information about the dimensions used for event
    /// summarization and aggregation.
    aggregation_detail: ?AggregationDetail,

    /// The end time of the event.
    end_time: ?i64,

    /// The assesed nature of the event.
    ///
    /// * Values:
    ///
    /// * `HEALTHY`
    ///
    /// * All `EventRules` are `ACTIVE`.
    ///
    /// * `UNHEALTHY`
    ///
    /// * Some `EventRules` are `ACTIVE` and some are `INACTIVE`.
    event_status: ?EventStatus,

    /// The unique identifier for a Managed Notification Child Event.
    id: []const u8,

    message_components: MessageComponents,

    /// The type of event causing the notification.
    ///
    /// * Values:
    ///
    /// * `ALERT`
    ///
    /// * A notification about an event where something was triggered, initiated,
    ///   reopened, deployed, or a threshold was breached.
    ///
    /// * `WARNING`
    ///
    /// * A notification about an event where an issue is about to arise. For
    ///   example, something is approaching a threshold.
    ///
    /// * `ANNOUNCEMENT`
    ///
    /// * A notification about an important event. For example, a step in a workflow
    ///   or escalation path or that a workflow was updated.
    ///
    /// * `INFORMATIONAL`
    ///
    /// * A notification about informational messages. For example, recommendations,
    ///   service announcements, or reminders.
    notification_type: NotificationType,

    /// The Organizational Unit Id that an Amazon Web Services account belongs to.
    organizational_unit_id: ?[]const u8,

    /// The schema version of the Managed Notification Child Event.
    schema_version: SchemaVersion,

    /// The source event URL.
    source_event_detail_url: ?[]const u8,

    /// The detailed URL for the source event.
    source_event_detail_url_display_text: ?[]const u8,

    /// The notification event start time.
    start_time: ?i64,

    /// A list of text values.
    text_parts: []const aws.map.MapEntry(TextPartValue),

    pub const json_field_names = .{
        .aggregate_managed_notification_event_arn = "aggregateManagedNotificationEventArn",
        .aggregation_detail = "aggregationDetail",
        .end_time = "endTime",
        .event_status = "eventStatus",
        .id = "id",
        .message_components = "messageComponents",
        .notification_type = "notificationType",
        .organizational_unit_id = "organizationalUnitId",
        .schema_version = "schemaVersion",
        .source_event_detail_url = "sourceEventDetailUrl",
        .source_event_detail_url_display_text = "sourceEventDetailUrlDisplayText",
        .start_time = "startTime",
        .text_parts = "textParts",
    };
};
