pub const DeleteEndpointRequest = struct {
    /// The ID of the endpoint.
    endpoint_id: []const u8,

    /// The ID of the Outposts.
    outpost_id: []const u8,

    pub const json_field_names = .{
        .endpoint_id = "EndpointId",
        .outpost_id = "OutpostId",
    };
};
