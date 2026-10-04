const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResponseStream = @import("response_stream.zig").ResponseStream;

pub const InvokeAssistantInput = struct {
    /// The ID assigned to a conversation. IoT SiteWise automatically generates a
    /// unique ID for you, and this parameter is never required.
    /// However, if you prefer to have your own ID, you must specify it here in UUID
    /// format. If you specify your own ID, it must be globally unique.
    conversation_id: ?[]const u8 = null,

    /// Specifies if to turn trace on or not. It is used to track the SiteWise
    /// Assistant's
    /// reasoning, and data access process.
    enable_trace: ?bool = null,

    /// A text message sent to the SiteWise Assistant by the user.
    message: []const u8,

    pub const json_field_names = .{
        .conversation_id = "conversationId",
        .enable_trace = "enableTrace",
        .message = "message",
    };
};

pub const InvokeAssistantOutput = struct {
    /// The ID of the conversation, in UUID format. This ID uniquely identifies the
    /// conversation within IoT SiteWise.
    conversation_id: []const u8,

    body: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *InvokeAssistantOutput) void {
        self.body.deinit();
    }

    pub const json_field_names = .{
        .body = "body",
        .conversation_id = "conversationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeAssistantInput, options: CallOptions) !InvokeAssistantOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeAssistantInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/assistant/invocation";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.conversation_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"conversationId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enable_trace) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enableTrace\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"message\":");
    try aws.json.writeValue(@TypeOf(input.message), input.message, allocator, &body_buf);
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

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !InvokeAssistantOutput {
    var result: InvokeAssistantOutput = .{
        .conversation_id = "",
    };
    errdefer {
        allocator.free(result.conversation_id);
    }
    if (stream_resp.headers.get("x-amz-iotsitewise-assistant-conversation-id")) |value| {
        result.conversation_id = try allocator.dupe(u8, value);
    }
    result.body = try aws.event_stream_reader.EventStreamReader.init(
        allocator,
        stream_resp.body,
    );
    stream_resp.deinitHeaders();

    return result;
}
