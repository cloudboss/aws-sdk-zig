const Endpoint = @import("endpoint.zig").Endpoint;

pub const ListEndpointsResult = struct {
    /// The list of endpoints associated with the specified Outpost.
    endpoints: ?[]const Endpoint = null,

    /// If the number of endpoints associated with the specified Outpost exceeds
    /// `MaxResults`,
    /// you can include this value in subsequent calls to this operation to retrieve
    /// more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoints = "Endpoints",
        .next_token = "NextToken",
    };
};
