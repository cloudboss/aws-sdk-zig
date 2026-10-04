const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetAttachmentInput = struct {
    /// A unique identifier for the attachment.
    attachment_id: []const u8,

    /// The authentication token associated with the participant's connection.
    connection_token: []const u8,

    /// The expiration time of the URL in ISO timestamp. It's specified in ISO 8601
    /// format:
    /// yyyy-MM-ddThh:mm:ss.SSSZ. For example, 2019-11-08T02:41:28.172Z.
    url_expiry_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .attachment_id = "AttachmentId",
        .connection_token = "ConnectionToken",
        .url_expiry_in_seconds = "UrlExpiryInSeconds",
    };
};

pub const GetAttachmentOutput = struct {
    /// The size of the attachment in bytes.
    attachment_size_in_bytes: ?i64 = null,

    /// This is the pre-signed URL that can be used for uploading the file to Amazon
    /// S3 when used in response
    /// to
    /// [StartAttachmentUpload](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_StartAttachmentUpload.html).
    url: ?[]const u8 = null,

    /// The expiration time of the URL in ISO timestamp. It's specified in ISO 8601
    /// format: yyyy-MM-ddThh:mm:ss.SSSZ. For example, 2019-11-08T02:41:28.172Z.
    url_expiry: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachment_size_in_bytes = "AttachmentSizeInBytes",
        .url = "Url",
        .url_expiry = "UrlExpiry",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAttachmentInput, options: CallOptions) !GetAttachmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAttachmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("participant.connect", "ConnectParticipant", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/participant/attachment";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AttachmentId\":");
    try aws.json.writeValue(@TypeOf(input.attachment_id), input.attachment_id, allocator, &body_buf);
    has_prev = true;
    if (input.url_expiry_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UrlExpiryInSeconds\":");
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
    try request.headers.put(allocator, "X-Amz-Bearer", input.connection_token);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAttachmentOutput {
    const result: GetAttachmentOutput = try aws.json.parseJsonObject(
        GetAttachmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
