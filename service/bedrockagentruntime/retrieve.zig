const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GuardrailConfiguration = @import("guardrail_configuration.zig").GuardrailConfiguration;
const KnowledgeBaseRetrievalConfiguration = @import("knowledge_base_retrieval_configuration.zig").KnowledgeBaseRetrievalConfiguration;
const KnowledgeBaseQuery = @import("knowledge_base_query.zig").KnowledgeBaseQuery;
const UserContext = @import("user_context.zig").UserContext;
const GuadrailAction = @import("guadrail_action.zig").GuadrailAction;
const KnowledgeBaseRetrievalResult = @import("knowledge_base_retrieval_result.zig").KnowledgeBaseRetrievalResult;

pub const RetrieveInput = struct {
    /// Guardrail settings.
    guardrail_configuration: ?GuardrailConfiguration = null,

    /// The unique identifier of the knowledge base to query.
    knowledge_base_id: []const u8,

    /// If there are more results than can fit in the response, the response returns
    /// a `nextToken`. Use this token in the `nextToken` field of another request to
    /// retrieve the next batch of results.
    next_token: ?[]const u8 = null,

    /// Contains configurations for the knowledge base query and retrieval process.
    /// For more information, see [Query
    /// configurations](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html).
    retrieval_configuration: ?KnowledgeBaseRetrievalConfiguration = null,

    /// Contains the query to send the knowledge base.
    retrieval_query: KnowledgeBaseQuery,

    /// Contains information about the user making the request. This is used for
    /// access control filtering to ensure that retrieval results only include
    /// documents the user is authorized to access.
    user_context: ?UserContext = null,

    pub const json_field_names = .{
        .guardrail_configuration = "guardrailConfiguration",
        .knowledge_base_id = "knowledgeBaseId",
        .next_token = "nextToken",
        .retrieval_configuration = "retrievalConfiguration",
        .retrieval_query = "retrievalQuery",
        .user_context = "userContext",
    };
};

pub const RetrieveOutput = struct {
    /// Specifies if there is a guardrail intervention in the response.
    guardrail_action: ?GuadrailAction = null,

    /// If there are more results than can fit in the response, the response returns
    /// a `nextToken`. Use this token in the `nextToken` field of another request to
    /// retrieve the next batch of results.
    next_token: ?[]const u8 = null,

    /// A list of results from querying the knowledge base.
    retrieval_results: ?[]const KnowledgeBaseRetrievalResult = null,

    pub const json_field_names = .{
        .guardrail_action = "guardrailAction",
        .next_token = "nextToken",
        .retrieval_results = "retrievalResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RetrieveInput, options: CallOptions) !RetrieveOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RetrieveInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgebases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/retrieve");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.guardrail_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"guardrailConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.retrieval_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"retrievalConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"retrievalQuery\":");
    try aws.json.writeValue(@TypeOf(input.retrieval_query), input.retrieval_query, allocator, &body_buf);
    has_prev = true;
    if (input.user_context) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userContext\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RetrieveOutput {
    const result: RetrieveOutput = try aws.json.parseJsonObject(
        RetrieveOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
