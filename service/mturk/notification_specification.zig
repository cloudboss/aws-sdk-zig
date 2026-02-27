const EventType = @import("event_type.zig").EventType;
const NotificationTransport = @import("notification_transport.zig").NotificationTransport;

/// The NotificationSpecification data structure describes a HIT
/// event notification for a HIT type.
pub const NotificationSpecification = struct {
    /// The target for notification messages. The Destination’s format is determined
    /// by the specified Transport:
    ///
    /// * When Transport is Email, the Destination is your email address.
    ///
    /// * When Transport is SQS, the Destination is your queue URL.
    ///
    /// * When Transport is SNS, the Destination is the ARN of your topic.
    destination: []const u8,

    /// The list of events that should cause notifications to be
    /// sent. Valid Values: AssignmentAccepted | AssignmentAbandoned |
    /// AssignmentReturned | AssignmentSubmitted | AssignmentRejected |
    /// AssignmentApproved | HITCreated | HITExtended | HITDisposed |
    /// HITReviewable | HITExpired | Ping. The Ping event is only valid for
    /// the SendTestEventNotification operation.
    event_types: []const EventType,

    /// The method Amazon Mechanical Turk uses to send the
    /// notification. Valid Values: Email | SQS | SNS.
    transport: NotificationTransport,

    /// The version of the Notification API to use. Valid value is
    /// 2006-05-05.
    version: []const u8,

    pub const json_field_names = .{
        .destination = "Destination",
        .event_types = "EventTypes",
        .transport = "Transport",
        .version = "Version",
    };
};
