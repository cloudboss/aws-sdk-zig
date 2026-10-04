const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KnowledgeBaseSummary = @import("knowledge_base_summary.zig").KnowledgeBaseSummary;

pub const ListKnowledgeBasesInput = struct {
    /// The maximum number of results to return in the response. If the total number
    /// of results is greater than this value, use the token returned in the
    /// response in the `nextToken` field when making another request to return the
    /// next batch of results.
    max_results: ?i32 = null,

    /// If the total number of results is greater than the `maxResults` value
    /// provided in the request, enter the token returned in the `nextToken` field
    /// in the response in this field to return the next batch of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListKnowledgeBasesOutput = struct {
    /// A list of knowledge bases with information about each knowledge base.
    knowledge_base_summaries: ?[]const KnowledgeBaseSummary = null,

    /// If the total number of results is greater than the `maxResults` value
    /// provided in the request, use this token when making another request in the
    /// `nextToken` field to return the next batch of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .knowledge_base_summaries = "knowledgeBaseSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListKnowledgeBasesInput, options: CallOptions) !ListKnowledgeBasesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListKnowledgeBasesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/knowledgebases/";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListKnowledgeBasesOutput {
    var result: ListKnowledgeBasesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListKnowledgeBasesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
