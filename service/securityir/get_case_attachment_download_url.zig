const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetCaseAttachmentDownloadUrlInput = struct {
    /// Required element for GetCaseAttachmentDownloadUrl to identify the attachment
    /// ID for downloading an attachment.
    attachment_id: []const u8,

    /// Required element for GetCaseAttachmentDownloadUrl to identify the case ID
    /// for downloading an attachment from.
    case_id: []const u8,

    pub const json_field_names = .{
        .attachment_id = "attachmentId",
        .case_id = "caseId",
    };
};

pub const GetCaseAttachmentDownloadUrlOutput = struct {
    /// Response element providing the Amazon S3 presigned URL to download an
    /// attachment.
    attachment_presigned_url: []const u8,

    pub const json_field_names = .{
        .attachment_presigned_url = "attachmentPresignedUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCaseAttachmentDownloadUrlInput, options: CallOptions) !GetCaseAttachmentDownloadUrlOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCaseAttachmentDownloadUrlInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("security-ir", "Security IR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/cases/");
    try path_buf.appendSlice(allocator, input.case_id);
    try path_buf.appendSlice(allocator, "/get-presigned-url/");
    try path_buf.appendSlice(allocator, input.attachment_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCaseAttachmentDownloadUrlOutput {
    const result: GetCaseAttachmentDownloadUrlOutput = try aws.json.parseJsonObject(
        GetCaseAttachmentDownloadUrlOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
