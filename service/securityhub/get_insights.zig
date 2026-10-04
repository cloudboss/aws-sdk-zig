const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Insight = @import("insight.zig").Insight;

pub const GetInsightsInput = struct {
    /// The ARNs of the insights to describe. If you don't provide any insight ARNs,
    /// then
    /// `GetInsights` returns all of your custom insights. It does not return any
    /// managed insights.
    insight_arns: ?[]const []const u8 = null,

    /// The maximum number of items to return in the response.
    max_results: ?i32 = null,

    /// The token that is required for pagination. On your first call to the
    /// `GetInsights` operation, set the value of this parameter to
    /// `NULL`.
    ///
    /// For subsequent calls to the operation, to continue listing data, set the
    /// value of this
    /// parameter to the value returned from the previous response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .insight_arns = "InsightArns",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const GetInsightsOutput = struct {
    /// The insights returned by the operation.
    insights: ?[]const Insight = null,

    /// The pagination token to use to request the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .insights = "Insights",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInsightsInput, options: CallOptions) !GetInsightsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInsightsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/insights/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.insight_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InsightArns\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInsightsOutput {
    var result: GetInsightsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetInsightsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
