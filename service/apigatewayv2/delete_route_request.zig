pub const DeleteRouteRequest = struct {
    /// The API identifier.
    api_id: []const u8,

    /// The route ID.
    route_id: []const u8,

    pub const json_field_names = .{
        .api_id = "ApiId",
        .route_id = "RouteId",
    };
};
