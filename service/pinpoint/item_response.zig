const aws = @import("aws");

const EndpointItemResponse = @import("endpoint_item_response.zig").EndpointItemResponse;
const EventItemResponse = @import("event_item_response.zig").EventItemResponse;

/// Provides information about the results of a request to create or update an
/// endpoint that's associated with an event.
pub const ItemResponse = struct {
    /// The response that was received after the endpoint data was accepted.
    endpoint_item_response: ?EndpointItemResponse = null,

    /// A multipart response object that contains a key and a value for each event
    /// in the request. In each object, the event ID is the key and an
    /// EventItemResponse object is the value.
    events_item_response: ?[]const aws.map.MapEntry(EventItemResponse) = null,

    pub const json_field_names = .{
        .endpoint_item_response = "EndpointItemResponse",
        .events_item_response = "EventsItemResponse",
    };
};
