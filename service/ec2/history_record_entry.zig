const EventInformation = @import("event_information.zig").EventInformation;
const FleetEventType = @import("fleet_event_type.zig").FleetEventType;

/// Describes an event in the history of an EC2 Fleet.
pub const HistoryRecordEntry = struct {
    /// Information about the event.
    event_information: ?EventInformation,

    /// The event type.
    event_type: ?FleetEventType,

    /// The date and time of the event, in UTC format (for example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    timestamp: ?i64,
};
