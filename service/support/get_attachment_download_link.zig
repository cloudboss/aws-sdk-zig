const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DownloadUrl = @import("download_url.zig").DownloadUrl;

pub const GetAttachmentDownloadLinkInput = struct {
    /// The unique identifier of the attachment for which to retrieve a download
    /// link. Attachment
    /// IDs are returned in the `AttachmentDetails` objects in the `attachments`
    /// field of a Communication returned by DescribeCommunications
    /// or DescribeCases.
    attachment_id: []const u8,

    /// Specifies whether to validate the request without actually returning a
    /// download link. When
    /// set to `true`, the request is validated but no URL is returned, and the
    /// operation
    /// returns a `DryRunOperationException`. When omitted or set to `false`, the
    /// request runs normally.
    dry_run: ?bool = null,

    pub const json_field_names = .{
        .attachment_id = "attachmentId",
        .dry_run = "dryRun",
    };
};

pub const GetAttachmentDownloadLinkOutput = struct {
    /// The presigned download URL and the date and time the URL expires.
    download_url: ?DownloadUrl = null,

    /// The name of the attachment file, including the file extension.
    file_name: []const u8,

    pub const json_field_names = .{
        .download_url = "downloadUrl",
        .file_name = "fileName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAttachmentDownloadLinkInput, options: CallOptions) !GetAttachmentDownloadLinkOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAttachmentDownloadLinkInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.GetAttachmentDownloadLink");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAttachmentDownloadLinkOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetAttachmentDownloadLinkOutput, body, allocator);
}
