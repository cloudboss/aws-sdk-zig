const aws = @import("aws");

const PublicEndpoint = @import("public_endpoint.zig").PublicEndpoint;
const Event = @import("event.zig").Event;

/// Specifies a batch of endpoints and events to process.
pub const EventsBatch = struct {
    /// A set of properties and attributes that are associated with the endpoint.
    endpoint: PublicEndpoint,

    /// A set of properties that are associated with the event.
    events: []const aws.map.MapEntry(Event),

    pub const json_field_names = .{
        .endpoint = "Endpoint",
        .events = "Events",
    };
};
