const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrafficDistributionGroupUserSummary = @import("traffic_distribution_group_user_summary.zig").TrafficDistributionGroupUserSummary;

pub const ListTrafficDistributionGroupUsersInput = struct {
    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous
    /// response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The identifier of the traffic distribution group.
    /// This can be the ID or the ARN if the API is being called in the Region where
    /// the traffic distribution group was created.
    /// The ARN must be provided if the call is from the replicated Region.
    traffic_distribution_group_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .traffic_distribution_group_id = "TrafficDistributionGroupId",
    };
};

pub const ListTrafficDistributionGroupUsersOutput = struct {
    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// A list of traffic distribution group users.
    traffic_distribution_group_user_summary_list: ?[]const TrafficDistributionGroupUserSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .traffic_distribution_group_user_summary_list = "TrafficDistributionGroupUserSummaryList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrafficDistributionGroupUsersInput, options: CallOptions) !ListTrafficDistributionGroupUsersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrafficDistributionGroupUsersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/traffic-distribution-group/");
    try path_buf.appendSlice(allocator, input.traffic_distribution_group_id);
    try path_buf.appendSlice(allocator, "/user");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrafficDistributionGroupUsersOutput {
    var result: ListTrafficDistributionGroupUsersOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListTrafficDistributionGroupUsersOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
