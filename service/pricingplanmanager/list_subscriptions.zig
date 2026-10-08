const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionSummary = @import("subscription_summary.zig").SubscriptionSummary;

pub const ListSubscriptionsInput = struct {
    /// A token from a previous `ListSubscriptions` response. If the response
    /// included a `nextToken`, there are more results available. Pass this value to
    /// retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
    };
};

pub const ListSubscriptionsOutput = struct {
    /// A token that indicates there are more results available. Pass this value in
    /// a subsequent `ListSubscriptions` request to retrieve the next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// The list of subscription summaries for the calling account.
    subscription_summaries: ?[]const SubscriptionSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .subscription_summaries = "subscriptionSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSubscriptionsInput, options: CallOptions) !ListSubscriptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pricingplanmanager", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("pricingplanmanager", "Pricing Plan Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/ListSubscriptions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
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
