const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Locale = @import("locale.zig").Locale;
const Recommendation = @import("recommendation.zig").Recommendation;

pub const ListRecommendationsInput = struct {
    /// The ID of the Amazon Web Services account.
    account_id: ?[]const u8 = null,

    /// The ID of the requested insight.
    insight_id: []const u8,

    /// A locale that specifies the language to use for recommendations.
    locale: ?Locale = null,

    /// The pagination token to use to retrieve
    /// the next page of results for this operation. If this value is null, it
    /// retrieves the first page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .insight_id = "InsightId",
        .locale = "Locale",
        .next_token = "NextToken",
    };
};

pub const ListRecommendationsOutput = struct {
    /// The pagination token to use to retrieve
    /// the next page of results for this operation. If there are no more pages,
    /// this value is null.
    next_token: ?[]const u8 = null,

    /// An array of the requested recommendations.
    recommendations: ?[]const Recommendation = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .recommendations = "Recommendations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRecommendationsInput, options: CallOptions) !ListRecommendationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devops-guru", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devops-guru", "DevOps Guru", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/recommendations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InsightId\":");
    try aws.json.writeValue(@TypeOf(input.insight_id), input.insight_id, allocator, &body_buf);
    has_prev = true;
    if (input.locale) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Locale\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRecommendationsOutput {
    var result: ListRecommendationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListRecommendationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
