const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Subscription = @import("subscription.zig").Subscription;

pub const DescribeNotificationSubscriptionsInput = struct {
    /// The maximum number of items to return with this call.
    limit: ?i32 = null,

    /// The marker for the next set of results. (You received this marker from a
    /// previous
    /// call.)
    marker: ?[]const u8 = null,

    /// The ID of the organization.
    organization_id: []const u8,

    pub const json_field_names = .{
        .limit = "Limit",
        .marker = "Marker",
        .organization_id = "OrganizationId",
    };
};

pub const DescribeNotificationSubscriptionsOutput = struct {
    /// The marker to use when requesting the next set of results. If there are no
    /// additional results, the string is empty.
    marker: ?[]const u8 = null,

    /// The subscriptions.
    subscriptions: ?[]const Subscription = null,

    pub const json_field_names = .{
        .marker = "Marker",
        .subscriptions = "Subscriptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeNotificationSubscriptionsInput, options: CallOptions) !DescribeNotificationSubscriptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workdocs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeNotificationSubscriptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workdocs", "WorkDocs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/v1/organizations/");
    try path_buf.appendSlice(allocator, input.organization_id);
    try path_buf.appendSlice(allocator, "/subscriptions");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.limit) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "limit=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "marker=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeNotificationSubscriptionsOutput {
    var result: DescribeNotificationSubscriptionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeNotificationSubscriptionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
