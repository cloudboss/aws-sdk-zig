const SubscriptionEvent = @import("subscription_event.zig").SubscriptionEvent;
const SubscriptionEventType = @import("subscription_event_type.zig").SubscriptionEventType;

/// Represents a single segment membership event.
pub const SubscriptionEventItem = struct {
    /// Whether the profile joined or left the segment. The following are valid
    /// values:
    ///
    /// * **JOINED**: The profile joined the segment.
    ///
    /// * **LEFT**: The profile left the segment.
    event: ?SubscriptionEvent = null,

    /// The type of event that triggered the membership change. The following are
    /// valid values:
    ///
    /// * **LIVE**: Real-time event triggered by a profile or
    /// calculated attribute change (Classic segments only).
    ///
    /// * **SCHEDULE**: Event generated during a scheduled
    /// execution.
    event_type: ?SubscriptionEventType = null,

    /// The unique identifier of a customer profile.
    profile_id: ?[]const u8 = null,

    /// The timestamp of when the membership change was detected.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .event = "Event",
        .event_type = "EventType",
        .profile_id = "ProfileId",
        .updated_at = "UpdatedAt",
    };
};
