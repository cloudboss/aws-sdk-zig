const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchCriteria = @import("search_criteria.zig").SearchCriteria;
const MemoryRecordSummary = @import("memory_record_summary.zig").MemoryRecordSummary;

pub const RetrieveMemoryRecordsInput = struct {
    /// The maximum number of results to return in a single call. The default value
    /// is 20.
    max_results: ?i32 = null,

    /// The identifier of the AgentCore Memory resource from which to retrieve
    /// memory records.
    memory_id: []const u8,

    /// The namespace prefix to filter memory records by. Searches for memory
    /// records in namespaces that start with the provided prefix. Either
    /// `namespace` or `namespacePath` is required.
    namespace: ?[]const u8 = null,

    /// Use namespacePath for hierarchical retrievals. Return all memory records
    /// where namespace falls under the same parent hierarchy. Either `namespace` or
    /// `namespacePath` is required.
    namespace_path: ?[]const u8 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The search criteria to use for finding relevant memory records. This
    /// includes the search query, memory strategy ID, and other search parameters.
    search_criteria: SearchCriteria,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .memory_id = "memoryId",
        .namespace = "namespace",
        .namespace_path = "namespacePath",
        .next_token = "nextToken",
        .search_criteria = "searchCriteria",
    };
};

pub const RetrieveMemoryRecordsOutput = struct {
    /// The list of memory record summaries that match the search criteria, ordered
    /// by relevance.
    memory_record_summaries: ?[]const MemoryRecordSummary = null,

    /// The token to use in a subsequent request to get the next set of results.
    /// This value is null when there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .memory_record_summaries = "memoryRecordSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RetrieveMemoryRecordsInput, options: CallOptions) !RetrieveMemoryRecordsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RetrieveMemoryRecordsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memories/");
    try path_buf.appendSlice(allocator, input.memory_id);
    try path_buf.appendSlice(allocator, "/retrieve");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.namespace) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"namespace\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.namespace_path) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"namespacePath\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"searchCriteria\":");
    try aws.json.writeValue(@TypeOf(input.search_criteria), input.search_criteria, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RetrieveMemoryRecordsOutput {
    const result: RetrieveMemoryRecordsOutput = try aws.json.parseJsonObject(
        RetrieveMemoryRecordsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
