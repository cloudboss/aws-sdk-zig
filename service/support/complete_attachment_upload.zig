const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CompletedUpload = @import("completed_upload.zig").CompletedUpload;
const UploadStatus = @import("upload_status.zig").UploadStatus;

pub const CompleteAttachmentUploadInput = struct {
    /// The list of parts being reported as completed in this call. Each entry must
    /// contain the `partIndex` of an uploaded part and the `ETag` returned by
    /// Amazon S3 when that part was uploaded.
    completed_uploads: []const CompletedUpload,

    /// Specifies whether to validate the request without actually completing the
    /// upload. When set
    /// to `true`, the request is validated but the upload isn't finalized, and the
    /// operation returns a `DryRunOperationException`. When omitted or set to
    /// `false`, the request runs normally.
    dry_run: ?bool = null,

    /// The identifier associated with the upload to complete.
    upload_id: []const u8,

    pub const json_field_names = .{
        .completed_uploads = "completedUploads",
        .dry_run = "dryRun",
        .upload_id = "uploadId",
    };
};

pub const CompleteAttachmentUploadOutput = struct {
    /// The status of the multipart upload after the operation finalizes the
    /// attachment. Valid values: `attachment-ready`, `attachment-not-ready`,
    /// and `failed`.
    upload_status: UploadStatus,

    pub const json_field_names = .{
        .upload_status = "uploadStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CompleteAttachmentUploadInput, options: CallOptions) !CompleteAttachmentUploadOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CompleteAttachmentUploadInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.CompleteAttachmentUpload");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CompleteAttachmentUploadOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CompleteAttachmentUploadOutput, body, allocator);
}
