const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionEventItem = @import("subscription_event_item.zig").SubscriptionEventItem;

pub const ListSegmentSubscriptionEventsInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The maximum number of events to return per page.
    max_results: ?i32 = null,

    /// The pagination token from the previous call to retrieve the next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// The unique name of the segment definition.
    segment_definition_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .segment_definition_name = "SegmentDefinitionName",
    };
};

pub const ListSegmentSubscriptionEventsOutput = struct {
    /// A list of segment membership events.
    events: ?[]const SubscriptionEventItem = null,

    /// The pagination token to use to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .events = "Events",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSegmentSubscriptionEventsInput, options: CallOptions) !ListSegmentSubscriptionEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSegmentSubscriptionEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/segment-definitions/");
    try path_buf.appendSlice(allocator, input.segment_definition_name);
    try path_buf.appendSlice(allocator, "/subscription-events");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max-results=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "next-token=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSegmentSubscriptionEventsOutput {
    const result: ListSegmentSubscriptionEventsOutput = try aws.json.parseJsonObject(
        ListSegmentSubscriptionEventsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
