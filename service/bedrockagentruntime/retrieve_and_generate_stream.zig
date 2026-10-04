const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RetrieveAndGenerateInput = @import("retrieve_and_generate_input.zig").RetrieveAndGenerateInput;
const RetrieveAndGenerateConfiguration = @import("retrieve_and_generate_configuration.zig").RetrieveAndGenerateConfiguration;
const RetrieveAndGenerateSessionConfiguration = @import("retrieve_and_generate_session_configuration.zig").RetrieveAndGenerateSessionConfiguration;
const RetrieveAndGenerateStreamResponseOutput = @import("retrieve_and_generate_stream_response_output.zig").RetrieveAndGenerateStreamResponseOutput;

pub const RetrieveAndGenerateStreamInput = struct {
    /// Contains the query to be made to the knowledge base.
    input: RetrieveAndGenerateInput,

    /// Contains configurations for the knowledge base query and retrieval process.
    /// For more information, see [Query
    /// configurations](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html).
    retrieve_and_generate_configuration: ?RetrieveAndGenerateConfiguration = null,

    /// Contains details about the session with the knowledge base.
    session_configuration: ?RetrieveAndGenerateSessionConfiguration = null,

    /// The unique identifier of the session. When you first make a
    /// `RetrieveAndGenerate` request, Amazon Bedrock automatically generates this
    /// value. You must reuse this value for all subsequent requests in the same
    /// conversational session. This value allows Amazon Bedrock to maintain context
    /// and knowledge from previous interactions. You can't explicitly set the
    /// `sessionId` yourself.
    session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .input = "input",
        .retrieve_and_generate_configuration = "retrieveAndGenerateConfiguration",
        .session_configuration = "sessionConfiguration",
        .session_id = "sessionId",
    };
};

pub const RetrieveAndGenerateStreamOutput = struct {
    /// The session ID.
    session_id: []const u8,

    stream: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *RetrieveAndGenerateStreamOutput) void {
        self.stream.deinit();
    }

    pub const json_field_names = .{
        .session_id = "sessionId",
        .stream = "stream",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RetrieveAndGenerateStreamInput, options: CallOptions) !RetrieveAndGenerateStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    stream_resp.deinitHeaders();
    errdefer stream_resp.body.deinit();

    const stream = try aws.event_stream_reader.EventStreamReader.init(allocator, stream_resp.body);
    return .{ .stream = stream };
}

fn serializeRequest(allocator: std.mem.Allocator, input: RetrieveAndGenerateStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/retrieveAndGenerateStream";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"input\":");
    try aws.json.writeValue(@TypeOf(input.input), input.input, allocator, &body_buf);
    has_prev = true;
    if (input.retrieve_and_generate_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"retrieveAndGenerateConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionId\":");
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
