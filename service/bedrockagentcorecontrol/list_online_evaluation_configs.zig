const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OnlineEvaluationConfigSummary = @import("online_evaluation_config_summary.zig").OnlineEvaluationConfigSummary;

pub const ListOnlineEvaluationConfigsInput = struct {
    /// The maximum number of online evaluation configurations to return in a single
    /// response.
    max_results: ?i32 = null,

    /// The pagination token from a previous request to retrieve the next page of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListOnlineEvaluationConfigsOutput = struct {
    /// The pagination token to use in a subsequent request to retrieve the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// The list of online evaluation configuration summaries containing basic
    /// information about each configuration.
    online_evaluation_configs: ?[]const OnlineEvaluationConfigSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .online_evaluation_configs = "onlineEvaluationConfigs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOnlineEvaluationConfigsInput, options: CallOptions) !ListOnlineEvaluationConfigsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListOnlineEvaluationConfigsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/online-evaluation-configs";

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
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOnlineEvaluationConfigsOutput {
    var result: ListOnlineEvaluationConfigsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListOnlineEvaluationConfigsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
