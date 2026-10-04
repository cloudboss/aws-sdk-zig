const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UploadProgress = @import("upload_progress.zig").UploadProgress;
const UploadStatus = @import("upload_status.zig").UploadStatus;

pub const DescribeAttachmentUploadStatusInput = struct {
    /// Specifies whether to validate the request without actually returning upload
    /// status. When
    /// set to `true`, the request is validated but no status is returned, and the
    /// operation
    /// returns a `DryRunOperationException`. When omitted or set to `false`, the
    /// request runs normally.
    dry_run: ?bool = null,

    /// The unique identifier for the upload. The `uploadId` is returned by
    /// GetAttachmentUploadLinks when you initiate the upload.
    upload_id: []const u8,

    pub const json_field_names = .{
        .dry_run = "dryRun",
        .upload_id = "uploadId",
    };
};

pub const DescribeAttachmentUploadStatusOutput = struct {
    /// The name of the file being uploaded, including the file extension.
    file_name: []const u8,

    /// The progress of the multipart upload, including the total number of parts
    /// and the number
    /// of parts that have been successfully uploaded.
    upload_progress: ?UploadProgress = null,

    /// The current status of the multipart upload. Valid values:
    /// `attachment-ready`,
    /// `attachment-not-ready`, and `failed`.
    upload_status: UploadStatus,

    pub const json_field_names = .{
        .file_name = "fileName",
        .upload_progress = "uploadProgress",
        .upload_status = "uploadStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAttachmentUploadStatusInput, options: CallOptions) !DescribeAttachmentUploadStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "support", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAttachmentUploadStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("support", "Support", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.DescribeAttachmentUploadStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAttachmentUploadStatusOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeAttachmentUploadStatusOutput, body, allocator);
}
