const ClientLocation = @import("client_location.zig").ClientLocation;
const InternetEventStatus = @import("internet_event_status.zig").InternetEventStatus;
const InternetEventType = @import("internet_event_type.zig").InternetEventType;

/// A summary of information about an internet event in Amazon CloudWatch
/// Internet Monitor. Internet events are issues that cause performance
/// degradation
/// or availability problems for impacted Amazon Web Services client locations.
/// Internet Monitor displays information about
/// recent global health events, called internet events, on a global outages map
/// that is available to all Amazon Web Services
/// customers.
pub const InternetEventSummary = struct {
    /// The impacted location, such as a city, that Amazon Web Services clients
    /// access application resources from.
    client_location: ClientLocation,

    /// The time when an internet event ended. If the event hasn't ended yet, this
    /// value
    /// is empty.
    ended_at: ?i64,

    /// The Amazon Resource Name (ARN) of the internet event.
    event_arn: []const u8,

    /// The internally-generated identifier of an internet event.
    event_id: []const u8,

    /// The status of an internet event.
    event_status: InternetEventStatus,

    /// The type of network impairment.
    event_type: InternetEventType,

    /// The time when an internet event started.
    started_at: i64,

    pub const json_field_names = .{
        .client_location = "ClientLocation",
        .ended_at = "EndedAt",
        .event_arn = "EventArn",
        .event_id = "EventId",
        .event_status = "EventStatus",
        .event_type = "EventType",
        .started_at = "StartedAt",
    };
};
