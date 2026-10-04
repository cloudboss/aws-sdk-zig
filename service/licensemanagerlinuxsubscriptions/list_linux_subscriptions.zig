const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const Subscription = @import("subscription.zig").Subscription;

pub const ListLinuxSubscriptionsInput = struct {
    /// An array of structures that you can use to filter the results to those that
    /// match one or
    /// more sets of key-value pairs that you specify. For example, you can filter
    /// by the name of
    /// `Subscription` with an optional operator to see subscriptions that match,
    /// partially match, or don't match a certain subscription's name.
    ///
    /// The valid names for this filter are:
    ///
    /// * `Subscription`
    ///
    /// The valid Operators for this filter are:
    ///
    /// * `contains`
    ///
    /// * `equals`
    ///
    /// * `Notequal`
    filters: ?[]const Filter = null,

    /// The maximum items to return in a request.
    max_results: ?i32 = null,

    /// A token to specify where to start paginating. This
    /// is the nextToken from a previously truncated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListLinuxSubscriptionsOutput = struct {
    /// The next token used for paginated responses. When this
    /// field isn't empty, there are additional elements that the service hasn't
    /// included in this request. Use this token with the next request to retrieve
    /// additional objects.
    next_token: ?[]const u8 = null,

    /// An array that contains subscription objects.
    subscriptions: ?[]const Subscription = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .subscriptions = "Subscriptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLinuxSubscriptionsInput, options: CallOptions) !ListLinuxSubscriptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "license-manager-linux-subscriptions", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLinuxSubscriptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager-linux-subscriptions", "License Manager Linux Subscriptions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/subscription/ListLinuxSubscriptions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLinuxSubscriptionsOutput {
    var result: ListLinuxSubscriptionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListLinuxSubscriptionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
