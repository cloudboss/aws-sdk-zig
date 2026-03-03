const EventInformation = @import("event_information.zig").EventInformation;
const EventType = @import("event_type.zig").EventType;

/// Describes an event in the history of the Spot Fleet request.
pub const HistoryRecord = struct {
    /// Information about the event.
    event_information: ?EventInformation = null,

    /// The event type.
    ///
    /// * `error` - An error with the Spot Fleet request.
    ///
    /// * `fleetRequestChange` - A change in the status or configuration of
    /// the Spot Fleet request.
    ///
    /// * `instanceChange` - An instance was launched or terminated.
    ///
    /// * `Information` - An informational event.
    event_type: ?EventType = null,

    /// The date and time of the event, in UTC format (for example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    timestamp: ?i64 = null,
};
