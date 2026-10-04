const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UploadRange = @import("upload_range.zig").UploadRange;
const UploadUrl = @import("upload_url.zig").UploadUrl;

pub const GetAttachmentUploadLinksInput = struct {
    /// Specifies whether to validate the request without actually generating upload
    /// URLs. When
    /// set to `true`, the request is validated but no URLs are returned, and the
    /// operation
    /// returns a `DryRunOperationException`. When omitted or set to `false`, the
    /// request runs normally.
    dry_run: ?bool = null,

    /// The name of the file to upload, including the file extension. This value is
    /// required when
    /// you initiate a new upload.
    file_name: []const u8,

    /// The total size of the file in bytes. The service uses this value to
    /// calculate the total
    /// number of parts and the size of each part. Required when you initiate a new
    /// upload (when
    /// `uploadId` isn't provided). Valid range: 1 to 157,286,400 bytes
    /// (approximately
    /// 150 MB).
    file_size_bytes: ?i64 = null,

    /// The unique identifier of an in-progress multipart upload, returned by a
    /// previous call to
    /// `GetAttachmentUploadLinks`. Specify `uploadId` to retrieve additional
    /// presigned upload URLs for an upload that has already been initiated.
    /// Required when
    /// `fileSizeBytes` isn't provided. Length: 1 to 2,048 characters.
    upload_id: ?[]const u8 = null,

    /// The range of part indexes for which to return presigned upload URLs. Use
    /// this parameter
    /// to page through the upload URLs for a large file across multiple calls. If
    /// you omit this
    /// parameter, the service determines the range to return.
    upload_range: ?UploadRange = null,

    pub const json_field_names = .{
        .dry_run = "dryRun",
        .file_name = "fileName",
        .file_size_bytes = "fileSizeBytes",
        .upload_id = "uploadId",
        .upload_range = "uploadRange",
    };
};

pub const GetAttachmentUploadLinksOutput = struct {
    /// The next part index to request presigned URLs for. If all upload URLs for
    /// the file have
    /// been returned, this field is `null`. Use this value as the `startIndex` in
    /// `uploadRange` on a subsequent call to `GetAttachmentUploadLinks` to
    /// retrieve the next batch of upload URLs.
    next_index: ?i32 = null,

    /// The size, in bytes, of each part. Split the file into parts of this size
    /// before you upload
    /// them to the presigned URLs. For an upload with `n` total parts, parts 1
    /// through
    /// `n` - 1 are exactly this size; the last part may be smaller. Maximum:
    /// 104,857,600 bytes (approximately 100 MB).
    part_size_bytes: i64,

    /// The total number of parts that the file is split into. Upload one part to
    /// each presigned
    /// URL.
    total_parts: ?i32 = null,

    /// The unique identifier for the multipart upload. Use this value in subsequent
    /// calls to
    /// `GetAttachmentUploadLinks`, DescribeAttachmentUploadStatus,
    /// and CompleteAttachmentUpload, and to attach the upload to a case through the
    /// `uploadIds` parameter on CreateCase or AddCommunicationToCase.
    upload_id: []const u8,

    /// The list of presigned upload URLs for the requested range of parts. The list
    /// contains at
    /// most 10 URLs per call. Upload each part to its corresponding URL by using
    /// HTTP
    /// `PUT` before the URL expires.
    upload_urls: ?[]const UploadUrl = null,

    pub const json_field_names = .{
        .next_index = "nextIndex",
        .part_size_bytes = "partSizeBytes",
        .total_parts = "totalParts",
        .upload_id = "uploadId",
        .upload_urls = "uploadUrls",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAttachmentUploadLinksInput, options: CallOptions) !GetAttachmentUploadLinksOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAttachmentUploadLinksInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.GetAttachmentUploadLinks");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAttachmentUploadLinksOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetAttachmentUploadLinksOutput, body, allocator);
}
