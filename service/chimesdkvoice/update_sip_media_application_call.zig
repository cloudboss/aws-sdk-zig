const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SipMediaApplicationCall = @import("sip_media_application_call.zig").SipMediaApplicationCall;

pub const UpdateSipMediaApplicationCallInput = struct {
    /// Arguments made available to the Lambda function as part of the
    /// `CALL_UPDATE_REQUESTED` event. Can contain 0-20 key-value pairs.
    arguments: []const aws.map.StringMapEntry,

    /// The ID of the SIP media application handling the call.
    sip_media_application_id: []const u8,

    /// The ID of the call transaction.
    transaction_id: []const u8,

    pub const json_field_names = .{
        .arguments = "Arguments",
        .sip_media_application_id = "SipMediaApplicationId",
        .transaction_id = "TransactionId",
    };
};

pub const UpdateSipMediaApplicationCallOutput = struct {
    /// A `Call` instance for a SIP media application.
    sip_media_application_call: ?SipMediaApplicationCall = null,

    pub const json_field_names = .{
        .sip_media_application_call = "SipMediaApplicationCall",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSipMediaApplicationCallInput, options: CallOptions) !UpdateSipMediaApplicationCallOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSipMediaApplicationCallInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sip-media-applications/");
    try path_buf.appendSlice(allocator, input.sip_media_application_id);
    try path_buf.appendSlice(allocator, "/calls/");
    try path_buf.appendSlice(allocator, input.transaction_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Arguments\":");
    try aws.json.writeValue(@TypeOf(input.arguments), input.arguments, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSipMediaApplicationCallOutput {
    var result: UpdateSipMediaApplicationCallOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSipMediaApplicationCallOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
