const GatewaySummary = @import("gateway_summary.zig").GatewaySummary;

pub const ListGatewaysResponse = struct {
    /// The list of gateway summaries.
    items: []const GatewaySummary,

    /// If the total number of results is greater than the `maxResults` value
    /// provided in the request, use this token when making another request in the
    /// `nextToken` field to return the next batch of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};
