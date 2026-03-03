const aws = @import("aws");

const AggregationEventType = @import("aggregation_event_type.zig").AggregationEventType;
const AggregationSummary = @import("aggregation_summary.zig").AggregationSummary;
const EventStatus = @import("event_status.zig").EventStatus;
const MessageComponents = @import("message_components.zig").MessageComponents;
const NotificationType = @import("notification_type.zig").NotificationType;
const SchemaVersion = @import("schema_version.zig").SchemaVersion;
const TextPartValue = @import("text_part_value.zig").TextPartValue;

/// A notification-focused representation of an event. They contain semantic
/// information used by AccountContacts or Additional Channels to create
/// end-user notifications.
pub const ManagedNotificationEvent = struct {
    /// The notifications aggregation type.
    aggregation_event_type: ?AggregationEventType = null,

    aggregation_summary: ?AggregationSummary = null,

    /// The end time of the notification event.
    end_time: ?i64 = null,

    /// The status of an event.
    ///
    /// * Values:
    ///
    /// * `HEALTHY`
    ///
    /// * All EventRules are `ACTIVE` and any call can be run.
    ///
    /// * `UNHEALTHY`
    ///
    /// * Some EventRules are `ACTIVE` and some are `INACTIVE`. Any call can be run.
    event_status: ?EventStatus = null,

    /// Unique identifier for a `ManagedNotificationEvent`.
    id: []const u8,

    message_components: MessageComponents,

    /// The nature of the event causing this notification.
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
    organizational_unit_id: ?[]const u8 = null,

    /// Version of the `ManagedNotificationEvent` schema.
    schema_version: SchemaVersion,

    /// URL defined by Source Service to be used by notification consumers to get
    /// additional information about event.
    source_event_detail_url: ?[]const u8 = null,

    /// Text that needs to be hyperlinked with the sourceEventDetailUrl. For
    /// example, the description of the sourceEventDetailUrl.
    source_event_detail_url_display_text: ?[]const u8 = null,

    /// The earliest time of events to return from this call.
    start_time: ?i64 = null,

    /// A list of text values.
    text_parts: []const aws.map.MapEntry(TextPartValue),

    pub const json_field_names = .{
        .aggregation_event_type = "aggregationEventType",
        .aggregation_summary = "aggregationSummary",
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
