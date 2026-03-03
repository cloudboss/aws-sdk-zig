const aws = @import("aws");

const AggregationEventType = @import("aggregation_event_type.zig").AggregationEventType;
const AggregationSummary = @import("aggregation_summary.zig").AggregationSummary;
const EventStatus = @import("event_status.zig").EventStatus;
const MediaElement = @import("media_element.zig").MediaElement;
const MessageComponents = @import("message_components.zig").MessageComponents;
const NotificationType = @import("notification_type.zig").NotificationType;
const SchemaVersion = @import("schema_version.zig").SchemaVersion;
const SourceEventMetadata = @import("source_event_metadata.zig").SourceEventMetadata;
const TextPartValue = @import("text_part_value.zig").TextPartValue;

/// A `NotificationEvent` is a notification-focused representation of an event.
/// They contain semantic information used by Channels to create end-user
/// notifications.
pub const NotificationEventSchema = struct {
    /// If the value of `aggregationEventType` is not `NONE`, this is the Amazon
    /// Resource Event (ARN) of the parent aggregate notification.
    ///
    /// This is omitted if notification isn't aggregated.
    aggregate_notification_event_arn: ?[]const u8 = null,

    /// The aggregation type of the `NotificationConfiguration`.
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

    /// Provides additional information about how multiple notifications are
    /// grouped.
    aggregation_summary: ?AggregationSummary = null,

    /// The end time of the event.
    end_time: ?i64 = null,

    /// The assessed nature of the event.
    ///
    /// * Values:
    ///
    /// * `HEALTHY`
    ///
    /// * All `EventRules` are `ACTIVE` and any call can be run.
    ///
    /// * `UNHEALTHY`
    ///
    /// * Some `EventRules` are `ACTIVE` and some are `INACTIVE`. Any call can be
    ///   run.
    event_status: ?EventStatus = null,

    /// The unique identifier for a `NotificationEvent`.
    id: []const u8,

    /// A list of media elements.
    media: []const MediaElement,

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

    /// The unique identifier of the organizational unit associated with the
    /// notification event.
    organizational_unit_id: ?[]const u8 = null,

    /// The schema version of the Notification Event.
    schema_version: SchemaVersion,

    /// The source event URL.
    source_event_detail_url: ?[]const u8 = null,

    /// The detailed URL for the source event.
    source_event_detail_url_display_text: ?[]const u8 = null,

    /// The source event metadata.
    source_event_metadata: SourceEventMetadata,

    /// The notification event start time.
    start_time: ?i64 = null,

    /// A list of text values.
    text_parts: []const aws.map.MapEntry(TextPartValue),

    pub const json_field_names = .{
        .aggregate_notification_event_arn = "aggregateNotificationEventArn",
        .aggregation_event_type = "aggregationEventType",
        .aggregation_summary = "aggregationSummary",
        .end_time = "endTime",
        .event_status = "eventStatus",
        .id = "id",
        .media = "media",
        .message_components = "messageComponents",
        .notification_type = "notificationType",
        .organizational_unit_id = "organizationalUnitId",
        .schema_version = "schemaVersion",
        .source_event_detail_url = "sourceEventDetailUrl",
        .source_event_detail_url_display_text = "sourceEventDetailUrlDisplayText",
        .source_event_metadata = "sourceEventMetadata",
        .start_time = "startTime",
        .text_parts = "textParts",
    };
};
