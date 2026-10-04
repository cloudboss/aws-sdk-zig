const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetCaseAttachmentUploadUrlInput = struct {
    /// Required element for GetCaseAttachmentUploadUrl to identify the case ID for
    /// uploading an attachment.
    case_id: []const u8,

    /// The `clientToken` field is an idempotency key used to ensure that repeated
    /// attempts for a single action will be ignored by the server during retries. A
    /// caller supplied unique ID (typically a UUID) should be provided.
    client_token: ?[]const u8 = null,

    /// Required element for GetCaseAttachmentUploadUrl to identify the size of the
    /// file attachment.
    content_length: i64,

    /// Required element for GetCaseAttachmentUploadUrl to identify the file name of
    /// the attachment to upload.
    file_name: []const u8,

    pub const json_field_names = .{
        .case_id = "caseId",
        .client_token = "clientToken",
        .content_length = "contentLength",
        .file_name = "fileName",
    };
};

pub const GetCaseAttachmentUploadUrlOutput = struct {
    /// Response element providing the Amazon S3 presigned URL to upload the
    /// attachment.
    attachment_presigned_url: []const u8,

    pub const json_field_names = .{
        .attachment_presigned_url = "attachmentPresignedUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCaseAttachmentUploadUrlInput, options: CallOptions) !GetCaseAttachmentUploadUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "security-ir", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCaseAttachmentUploadUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("security-ir", "Security IR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/cases/");
    try path_buf.appendSlice(allocator, input.case_id);
    try path_buf.appendSlice(allocator, "/get-presigned-url");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"contentLength\":");
    try aws.json.writeValue(@TypeOf(input.content_length), input.content_length, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"fileName\":");
    try aws.json.writeValue(@TypeOf(input.file_name), input.file_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCaseAttachmentUploadUrlOutput {
    var result: GetCaseAttachmentUploadUrlOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCaseAttachmentUploadUrlOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
