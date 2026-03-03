const EventSeverity = @import("event_severity.zig").EventSeverity;

/// Describes an event.
pub const EventDescription = struct {
    /// The application associated with the event.
    application_name: ?[]const u8 = null,

    /// The name of the environment associated with this event.
    environment_name: ?[]const u8 = null,

    /// The date when the event occurred.
    event_date: ?i64 = null,

    /// The event message.
    message: ?[]const u8 = null,

    /// The ARN of the platform version.
    platform_arn: ?[]const u8 = null,

    /// The web service request ID for the activity of this event.
    request_id: ?[]const u8 = null,

    /// The severity level of this event.
    severity: ?EventSeverity = null,

    /// The name of the configuration associated with this event.
    template_name: ?[]const u8 = null,

    /// The release label for the application version associated with this event.
    version_label: ?[]const u8 = null,
};
