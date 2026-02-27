const EndpointResponse = @import("endpoint_response.zig").EndpointResponse;

/// Provides information about all the endpoints that are associated with a user
/// ID.
pub const EndpointsResponse = struct {
    /// An array of responses, one for each endpoint that's associated with the user
    /// ID.
    item: []const EndpointResponse,

    pub const json_field_names = .{
        .item = "Item",
    };
};
