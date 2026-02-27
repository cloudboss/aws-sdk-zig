const EventStatus = @import("event_status.zig").EventStatus;
const MessageComponentsSummary = @import("message_components_summary.zig").MessageComponentsSummary;
const NotificationType = @import("notification_type.zig").NotificationType;
const SchemaVersion = @import("schema_version.zig").SchemaVersion;
const SourceEventMetadataSummary = @import("source_event_metadata_summary.zig").SourceEventMetadataSummary;

/// Describes a short summary and metadata for a `NotificationEvent`.
pub const NotificationEventSummary = struct {
    /// Provides additional information about the current status of the
    /// `NotificationEvent`.
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
    event_status: EventStatus,

    /// The message components of a notification event.
    message_components: MessageComponentsSummary,

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

    /// The schema version of the Notification Event.
    schema_version: SchemaVersion,

    /// The source event metadata.
    source_event_metadata: SourceEventMetadataSummary,

    pub const json_field_names = .{
        .event_status = "eventStatus",
        .message_components = "messageComponents",
        .notification_type = "notificationType",
        .schema_version = "schemaVersion",
        .source_event_metadata = "sourceEventMetadata",
    };
};
