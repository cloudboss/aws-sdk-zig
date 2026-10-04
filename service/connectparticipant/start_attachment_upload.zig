const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UploadMetadata = @import("upload_metadata.zig").UploadMetadata;

pub const StartAttachmentUploadInput = struct {
    /// A case-sensitive name of the attachment being uploaded.
    attachment_name: []const u8,

    /// The size of the attachment in bytes.
    attachment_size_in_bytes: ?i64 = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: []const u8,

    /// The authentication token associated with the participant's connection.
    connection_token: []const u8,

    /// Describes the MIME file type of the attachment. For a list of supported file
    /// types, see [Feature
    /// specifications](https://docs.aws.amazon.com/connect/latest/adminguide/feature-limits.html) in the *Amazon Connect Administrator Guide*.
    content_type: []const u8,

    pub const json_field_names = .{
        .attachment_name = "AttachmentName",
        .attachment_size_in_bytes = "AttachmentSizeInBytes",
        .client_token = "ClientToken",
        .connection_token = "ConnectionToken",
        .content_type = "ContentType",
    };
};

pub const StartAttachmentUploadOutput = struct {
    /// A unique identifier for the attachment.
    attachment_id: ?[]const u8 = null,

    /// The headers to be provided while uploading the file to the URL.
    upload_metadata: ?UploadMetadata = null,

    pub const json_field_names = .{
        .attachment_id = "AttachmentId",
        .upload_metadata = "UploadMetadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAttachmentUploadInput, options: CallOptions) !StartAttachmentUploadOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAttachmentUploadInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("participant.connect", "ConnectParticipant", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/participant/start-attachment-upload";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AttachmentName\":");
    try aws.json.writeValue(@TypeOf(input.attachment_name), input.attachment_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AttachmentSizeInBytes\":");
    try aws.json.writeValue(@TypeOf(input.attachment_size_in_bytes), input.attachment_size_in_bytes, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAttachmentUploadOutput {
    var result: StartAttachmentUploadOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartAttachmentUploadOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
