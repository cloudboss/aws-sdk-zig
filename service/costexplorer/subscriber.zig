const SubscriberStatus = @import("subscriber_status.zig").SubscriberStatus;
const SubscriberType = @import("subscriber_type.zig").SubscriberType;

/// The recipient of `AnomalySubscription` notifications.
pub const Subscriber = struct {
    /// The email address or SNS Amazon Resource Name (ARN). This depends on the
    /// `Type`.
    address: ?[]const u8,

    /// Indicates if the subscriber accepts the notifications.
    status: ?SubscriberStatus,

    /// The notification delivery channel.
    type: ?SubscriberType,

    pub const json_field_names = .{
        .address = "Address",
        .status = "Status",
        .type = "Type",
    };
};
