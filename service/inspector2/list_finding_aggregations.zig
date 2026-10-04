const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StringFilter = @import("string_filter.zig").StringFilter;
const AggregationRequest = @import("aggregation_request.zig").AggregationRequest;
const AggregationType = @import("aggregation_type.zig").AggregationType;
const AggregationResponse = @import("aggregation_response.zig").AggregationResponse;

pub const ListFindingAggregationsInput = struct {
    /// The Amazon Web Services account IDs to retrieve finding aggregation data
    /// for.
    account_ids: ?[]const StringFilter = null,

    /// Details of the aggregation request that is used to filter your aggregation
    /// results.
    aggregation_request: ?AggregationRequest = null,

    /// The type of the aggregation request.
    aggregation_type: AggregationType,

    /// The maximum number of results the response can return. If your request would
    /// return more
    /// than the maximum the response will return a `nextToken` value, use this
    /// value
    /// when you call the action again to get the remaining results.
    max_results: ?i32 = null,

    /// A token to use for paginating results that are returned in the response. Set
    /// the value
    /// of this parameter to null for the first request to a list action. If your
    /// response returns
    /// more than the `maxResults` maximum value it will also return a
    /// `nextToken` value. For subsequent calls, use the `nextToken` value
    /// returned from the previous request to continue listing results after the
    /// first page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .aggregation_request = "aggregationRequest",
        .aggregation_type = "aggregationType",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListFindingAggregationsOutput = struct {
    /// The type of aggregation to perform.
    aggregation_type: AggregationType,

    /// A token to use for paginating results that are returned in the response. Set
    /// the value
    /// of this parameter to null for the first request to a list action. For
    /// subsequent calls, use
    /// the `NextToken` value returned from the previous request to continue listing
    /// results after the first page.
    next_token: ?[]const u8 = null,

    /// Objects that contain the results of an aggregation operation.
    responses: ?[]const AggregationResponse = null,

    pub const json_field_names = .{
        .aggregation_type = "aggregationType",
        .next_token = "nextToken",
        .responses = "responses",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFindingAggregationsInput, options: CallOptions) !ListFindingAggregationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFindingAggregationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/findings/aggregation/list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accountIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.aggregation_request) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"aggregationRequest\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"aggregationType\":");
    try aws.json.writeValue(@TypeOf(input.aggregation_type), input.aggregation_type, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFindingAggregationsOutput {
    const result: ListFindingAggregationsOutput = try aws.json.parseJsonObject(
        ListFindingAggregationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
