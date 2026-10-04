const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VoiceMessageContent = @import("voice_message_content.zig").VoiceMessageContent;

pub const SendVoiceMessageInput = struct {
    /// The phone number that appears on recipients' devices when they receive the
    /// message.
    caller_id: ?[]const u8 = null,

    /// The name of the configuration set that you want to use to send the message.
    configuration_set_name: ?[]const u8 = null,

    content: ?VoiceMessageContent = null,

    /// The phone number that you want to send the voice message to.
    destination_phone_number: ?[]const u8 = null,

    /// The phone number that Amazon Pinpoint should use to send the voice message.
    /// This isn't necessarily the phone number that appears on recipients' devices
    /// when they receive the message, because you can specify a CallerId parameter
    /// in the request.
    origination_phone_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .caller_id = "CallerId",
        .configuration_set_name = "ConfigurationSetName",
        .content = "Content",
        .destination_phone_number = "DestinationPhoneNumber",
        .origination_phone_number = "OriginationPhoneNumber",
    };
};

pub const SendVoiceMessageOutput = struct {
    /// A unique identifier for the voice message.
    message_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .message_id = "MessageId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendVoiceMessageInput, options: CallOptions) !SendVoiceMessageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendVoiceMessageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice.pinpoint", "Pinpoint SMS Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/sms-voice/voice/message";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.caller_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CallerId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.configuration_set_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConfigurationSetName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.content) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Content\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.destination_phone_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DestinationPhoneNumber\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.origination_phone_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OriginationPhoneNumber\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendVoiceMessageOutput {
    const result: SendVoiceMessageOutput = try aws.json.parseJsonObject(
        SendVoiceMessageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
