const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JourneyExecutionMetricsResponse = @import("journey_execution_metrics_response.zig").JourneyExecutionMetricsResponse;

pub const GetJourneyExecutionMetricsInput = struct {
    /// The unique identifier for the application. This identifier is displayed as
    /// the **Project ID** on the Amazon Pinpoint console.
    application_id: []const u8,

    /// The unique identifier for the journey.
    journey_id: []const u8,

    /// The string that specifies which page of results to return in a paginated
    /// response. This parameter is not supported for application, campaign, and
    /// journey metrics.
    next_token: ?[]const u8 = null,

    /// The maximum number of items to include in each page of a paginated response.
    /// This parameter is not supported for application, campaign, and journey
    /// metrics.
    page_size: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .journey_id = "JourneyId",
        .next_token = "NextToken",
        .page_size = "PageSize",
    };
};

pub const GetJourneyExecutionMetricsOutput = struct {
    journey_execution_metrics_response: ?JourneyExecutionMetricsResponse = null,

    pub const json_field_names = .{
        .journey_execution_metrics_response = "JourneyExecutionMetricsResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetJourneyExecutionMetricsInput, options: CallOptions) !GetJourneyExecutionMetricsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mobiletargeting", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetJourneyExecutionMetricsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pinpoint", "Pinpoint", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/apps/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/journeys/");
    try path_buf.appendSlice(allocator, input.journey_id);
    try path_buf.appendSlice(allocator, "/execution-metrics");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "next-token=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.page_size) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "page-size=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetJourneyExecutionMetricsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: GetJourneyExecutionMetricsOutput = .{};

    return result;
}
