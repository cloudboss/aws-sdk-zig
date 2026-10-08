const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgenticRetrieveConfiguration = @import("agentic_retrieve_configuration.zig").AgenticRetrieveConfiguration;
const AgenticRetrieveMemoryConfiguration = @import("agentic_retrieve_memory_configuration.zig").AgenticRetrieveMemoryConfiguration;
const AgenticRetrieveMessage = @import("agentic_retrieve_message.zig").AgenticRetrieveMessage;
const AgenticRetrievePolicyConfiguration = @import("agentic_retrieve_policy_configuration.zig").AgenticRetrievePolicyConfiguration;
const AgenticRetriever = @import("agentic_retriever.zig").AgenticRetriever;
const UserContext = @import("user_context.zig").UserContext;
const AgenticRetrieveStreamResponseOutput = @import("agentic_retrieve_stream_response_output.zig").AgenticRetrieveStreamResponseOutput;

pub const AgenticRetrieveStreamInput = struct {
    /// Configuration settings for the agentic retrieval operation.
    agentic_retrieve_configuration: AgenticRetrieveConfiguration,

    /// Whether to generate a response based on the retrieved results.
    generate_response: ?bool = null,

    /// The configuration for using an Amazon Bedrock AgentCore Memory resource with
    /// this retrieval.
    memory_configuration: ?AgenticRetrieveMemoryConfiguration = null,

    /// The list of messages for the agentic retrieval conversation.
    messages: []const AgenticRetrieveMessage,

    /// Opaque continuation token for paginated results.
    next_token: ?[]const u8 = null,

    /// Policy configuration for guardrails and content filtering.
    policy_configuration: ?AgenticRetrievePolicyConfiguration = null,

    /// The list of retrievers to use for agentic retrieval.
    retrievers: []const AgenticRetriever,

    /// Contains information about the user making the request. This is used for
    /// access control filtering to ensure that retrieval results only include
    /// documents the user is authorized to access.
    user_context: ?UserContext = null,

    pub const json_field_names = .{
        .agentic_retrieve_configuration = "agenticRetrieveConfiguration",
        .generate_response = "generateResponse",
        .memory_configuration = "memoryConfiguration",
        .messages = "messages",
        .next_token = "nextToken",
        .policy_configuration = "policyConfiguration",
        .retrievers = "retrievers",
        .user_context = "userContext",
    };
};

pub const AgenticRetrieveStreamOutput = struct {
    stream: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *AgenticRetrieveStreamOutput) void {
        self.stream.deinit();
    }

    pub const json_field_names = .{
        .stream = "stream",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AgenticRetrieveStreamInput, options: CallOptions) !AgenticRetrieveStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    errdefer stream_resp.deinit();
    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: AgenticRetrieveStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/agenticRetrieveStream";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agenticRetrieveConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.agentic_retrieve_configuration), input.agentic_retrieve_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.generate_response) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"generateResponse\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.memory_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"memoryConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"messages\":");
    try aws.json.writeValue(@TypeOf(input.messages), input.messages, allocator, &body_buf);
    has_prev = true;
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.policy_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policyConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"retrievers\":");
    try aws.json.writeValue(@TypeOf(input.retrievers), input.retrievers, allocator, &body_buf);
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

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !AgenticRetrieveStreamOutput {
    var result: AgenticRetrieveStreamOutput = .{};
    result.stream = try aws.event_stream_reader.EventStreamReader.init(
        allocator,
        stream_resp.body,
    );
    stream_resp.deinitHeaders();

    return result;
}
