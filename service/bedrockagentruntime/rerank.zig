const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RerankQuery = @import("rerank_query.zig").RerankQuery;
const RerankingConfiguration = @import("reranking_configuration.zig").RerankingConfiguration;
const RerankSource = @import("rerank_source.zig").RerankSource;
const RerankResult = @import("rerank_result.zig").RerankResult;

pub const RerankInput = struct {
    /// If the total number of results was greater than could fit in a response, a
    /// token is returned in the `nextToken` field. You can enter that token in this
    /// field to return the next batch of results.
    next_token: ?[]const u8 = null,

    /// An array of objects, each of which contains information about a query to
    /// submit to the reranker model.
    queries: []const RerankQuery,

    /// Contains configurations for reranking.
    reranking_configuration: RerankingConfiguration,

    /// An array of objects, each of which contains information about the sources to
    /// rerank.
    sources: []const RerankSource,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .queries = "queries",
        .reranking_configuration = "rerankingConfiguration",
        .sources = "sources",
    };
};

pub const RerankOutput = struct {
    /// If the total number of results is greater than can fit in the response, use
    /// this token in the `nextToken` field when making another request to return
    /// the next batch of results.
    next_token: ?[]const u8 = null,

    /// An array of objects, each of which contains information about the results of
    /// reranking.
    results: ?[]const RerankResult = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .results = "results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RerankInput, options: CallOptions) !RerankOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RerankInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/rerank";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"queries\":");
    try aws.json.writeValue(@TypeOf(input.queries), input.queries, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"rerankingConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.reranking_configuration), input.reranking_configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sources\":");
    try aws.json.writeValue(@TypeOf(input.sources), input.sources, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RerankOutput {
    var result: RerankOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RerankOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
