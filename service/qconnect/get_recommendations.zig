const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationType = @import("recommendation_type.zig").RecommendationType;
const RecommendationData = @import("recommendation_data.zig").RecommendationData;
const RecommendationTrigger = @import("recommendation_trigger.zig").RecommendationTrigger;

pub const GetRecommendationsInput = struct {
    /// The identifier of the Amazon Q in Connect assistant. Can be either the ID or
    /// the ARN. URLs cannot contain the ARN.
    assistant_id: []const u8,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of chunks. Use the value returned in the previous
    /// response in the next request to retrieve the next set of chunks.
    next_chunk_token: ?[]const u8 = null,

    /// The type of recommendation being requested.
    recommendation_type: ?RecommendationType = null,

    /// The identifier of the session. Can be either the ID or the ARN. URLs cannot
    /// contain the ARN.
    session_id: []const u8,

    /// The duration (in seconds) for which the call waits for a recommendation to
    /// be made available before returning. If a recommendation is available, the
    /// call returns sooner than `WaitTimeSeconds`. If no messages are available and
    /// the wait time expires, the call returns successfully with an empty list.
    wait_time_seconds: ?i32 = null,

    pub const json_field_names = .{
        .assistant_id = "assistantId",
        .max_results = "maxResults",
        .next_chunk_token = "nextChunkToken",
        .recommendation_type = "recommendationType",
        .session_id = "sessionId",
        .wait_time_seconds = "waitTimeSeconds",
    };
};

pub const GetRecommendationsOutput = struct {
    /// The recommendations.
    recommendations: ?[]const RecommendationData = null,

    /// The triggers corresponding to recommendations.
    triggers: ?[]const RecommendationTrigger = null,

    pub const json_field_names = .{
        .recommendations = "recommendations",
        .triggers = "triggers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecommendationsInput, options: CallOptions) !GetRecommendationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wisdom", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assistants/");
    try path_buf.appendSlice(allocator, input.assistant_id);
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_id);
    try path_buf.appendSlice(allocator, "/recommendations");
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
    if (input.next_chunk_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextChunkToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.recommendation_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "recommendationType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.wait_time_seconds) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "waitTimeSeconds=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecommendationsOutput {
    var result: GetRecommendationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRecommendationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
