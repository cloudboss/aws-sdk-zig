const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MessageProcessingMetadata = @import("message_processing_metadata.zig").MessageProcessingMetadata;

pub const SendMessageInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The authentication token associated with the connection.
    connection_token: []const u8,

    /// The content of the message.
    ///
    /// * For `text/plain` and `text/markdown`, the Length
    /// Constraints are Minimum of 1, Maximum of 1024.
    ///
    /// * For `application/json`, the Length Constraints are Minimum of 1,
    /// Maximum of 12000.
    ///
    /// * For
    /// `application/vnd.amazonaws.connect.message.interactive.response`,
    /// the Length Constraints are Minimum of 1, Maximum of 12288.
    content: []const u8,

    /// The type of the content. Possible types are `text/plain`,
    /// `text/markdown`, `application/json`, and
    /// `application/vnd.amazonaws.connect.message.interactive.response`.
    ///
    /// Supported types on the contact are configured through
    /// `SupportedMessagingContentTypes` on
    /// [StartChatContact](https://docs.aws.amazon.com/connect/latest/APIReference/API_StartChatContact.html)
    /// and
    /// [StartOutboundChatContact](https://docs.aws.amazon.com/connect/latest/APIReference/API_StartOutboundChatContact.html).
    ///
    /// For Apple Messages for Business, SMS, and WhatsApp Business Messaging
    /// contacts, only
    /// `text/plain` is supported.
    content_type: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .connection_token = "ConnectionToken",
        .content = "Content",
        .content_type = "ContentType",
    };
};

pub const SendMessageOutput = struct {
    /// The time when the message was sent.
    ///
    /// It's specified in ISO 8601 format: yyyy-MM-ddThh:mm:ss.SSSZ. For example,
    /// 2019-11-08T02:41:28.172Z.
    absolute_time: ?[]const u8 = null,

    /// The ID of the message.
    id: ?[]const u8 = null,

    /// Contains metadata for the message.
    message_metadata: ?MessageProcessingMetadata = null,

    pub const json_field_names = .{
        .absolute_time = "AbsoluteTime",
        .id = "Id",
        .message_metadata = "MessageMetadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendMessageInput, options: CallOptions) !SendMessageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendMessageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("participant.connect", "ConnectParticipant", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/participant/message";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Content\":");
    try aws.json.writeValue(@TypeOf(input.content), input.content, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ContentType\":");
    try aws.json.writeValue(@TypeOf(input.content_type), input.content_type, allocator, &body_buf);
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
    try request.headers.put(allocator, "X-Amz-Bearer", input.connection_token);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendMessageOutput {
    var result: SendMessageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SendMessageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
