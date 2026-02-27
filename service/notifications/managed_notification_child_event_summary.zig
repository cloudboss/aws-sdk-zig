const AggregationDetail = @import("aggregation_detail.zig").AggregationDetail;
const EventStatus = @import("event_status.zig").EventStatus;
const MessageComponentsSummary = @import("message_components_summary.zig").MessageComponentsSummary;
const NotificationType = @import("notification_type.zig").NotificationType;
const SchemaVersion = @import("schema_version.zig").SchemaVersion;
const ManagedSourceEventMetadataSummary = @import("managed_source_event_metadata_summary.zig").ManagedSourceEventMetadataSummary;

/// Describes a short summary and metadata for a
/// `ManagedNotificationChildEvent`.
pub const ManagedNotificationChildEventSummary = struct {
    /// Provides detailed information about the dimensions used for event
    /// summarization and aggregation.
    aggregation_detail: AggregationDetail,

    /// The perceived nature of the event.
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
    event_status: EventStatus,

    message_components: MessageComponentsSummary,

    /// The Type of the event causing this notification.
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

    /// The schema version of the `ManagedNotificationChildEvent`.
    schema_version: SchemaVersion,

    /// Contains all event metadata present identically across all
    /// `NotificationEvents`. All fields are present in Source Events via
    /// Eventbridge.
    source_event_metadata: ManagedSourceEventMetadataSummary,

    pub const json_field_names = .{
        .aggregation_detail = "aggregationDetail",
        .event_status = "eventStatus",
        .message_components = "messageComponents",
        .notification_type = "notificationType",
        .schema_version = "schemaVersion",
        .source_event_metadata = "sourceEventMetadata",
    };
};
