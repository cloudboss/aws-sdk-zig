const EventStatus = @import("event_status.zig").EventStatus;
const MessageComponentsSummary = @import("message_components_summary.zig").MessageComponentsSummary;
const NotificationType = @import("notification_type.zig").NotificationType;
const SchemaVersion = @import("schema_version.zig").SchemaVersion;
const ManagedSourceEventMetadataSummary = @import("managed_source_event_metadata_summary.zig").ManagedSourceEventMetadataSummary;

/// A short summary of a `ManagedNotificationEvent`. This is only used when
/// listing managed notification events.
pub const ManagedNotificationEventSummary = struct {
    /// The managed notification event status.
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

    message_components: MessageComponentsSummary,

    /// The Type of event causing the notification.
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

    /// The schema version of the `ManagedNotificationEvent`.
    schema_version: SchemaVersion,

    /// Contains metadata about the event that caused the
    /// `ManagedNotificationEvent`.
    source_event_metadata: ManagedSourceEventMetadataSummary,

    pub const json_field_names = .{
        .event_status = "eventStatus",
        .message_components = "messageComponents",
        .notification_type = "notificationType",
        .schema_version = "schemaVersion",
        .source_event_metadata = "sourceEventMetadata",
    };
};
