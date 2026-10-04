const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetMediaInput = struct {
    /// The identifier of the Amazon Q Business which contains the media object.
    application_id: []const u8,

    /// The identifier of the Amazon Q Business conversation.
    conversation_id: []const u8,

    /// The identifier of the media object. You can find this in the
    /// `sourceAttributions` returned by the `Chat`, `ChatSync`, and `ListMessages`
    /// API responses.
    media_id: []const u8,

    /// The identifier of the Amazon Q Business message.
    message_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .conversation_id = "conversationId",
        .media_id = "mediaId",
        .message_id = "messageId",
    };
};

pub const GetMediaOutput = struct {
    /// The base64-encoded bytes of the media object.
    media_bytes: ?[]const u8 = null,

    /// The MIME type of the media object (image/png).
    media_mime_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .media_bytes = "mediaBytes",
        .media_mime_type = "mediaMimeType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMediaInput, options: CallOptions) !GetMediaOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMediaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/conversations/");
    try path_buf.appendSlice(allocator, input.conversation_id);
    try path_buf.appendSlice(allocator, "/messages/");
    try path_buf.appendSlice(allocator, input.message_id);
    try path_buf.appendSlice(allocator, "/media/");
    try path_buf.appendSlice(allocator, input.media_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMediaOutput {
    var result: GetMediaOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetMediaOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
