const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionSummary = @import("subscription_summary.zig").SubscriptionSummary;

pub const ListSubscriptionsInput = struct {
    /// The unique identifier of the MQTT client to list subscriptions for. The
    /// client ID can't start with a dollar sign ($).
    ///
    /// MQTT client IDs must be URL encoded (percent-encoded) when they contain
    /// characters that are not valid in HTTP requests, such as spaces, forward
    /// slashes (/), and UTF-8 characters.
    client_id: []const u8,

    /// The maximum number of subscriptions to return in a single request. By
    /// default, this is set to 20.
    max_results: ?i32 = null,

    /// To retrieve the next set of results, the `nextToken`
    /// value from a previous response; otherwise **null** to receive
    /// the first set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_id = "clientId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListSubscriptionsOutput = struct {
    /// The token to use to get the next set of results, or **null** if there are no
    /// additional results.
    next_token: ?[]const u8 = null,

    /// A list of topic filters and their associated Quality of Service (QoS) levels
    /// that the client is subscribed to.
    subscriptions: ?[]const SubscriptionSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .subscriptions = "subscriptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSubscriptionsInput, options: CallOptions) !ListSubscriptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotdata", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSubscriptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data-ats.iot", "IoT Data Plane", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/connections/");
    try path_buf.appendSlice(allocator, input.client_id);
    try path_buf.appendSlice(allocator, "/subscriptions");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSubscriptionsOutput {
    const result: ListSubscriptionsOutput = try aws.json.parseJsonObject(
        ListSubscriptionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
