const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Attachment = @import("attachment.zig").Attachment;

pub const DescribeAttachmentInput = struct {
    /// The ID of the attachment to return. Attachment IDs are returned by the
    /// DescribeCommunications operation.
    ///
    /// If the specified attachment is larger than 5 MB, this operation returns
    /// `InvalidParameterValueException`. To download attachments larger than 5
    /// MB, use GetAttachmentDownloadLink.
    attachment_id: []const u8,

    /// Specifies whether to validate the request without actually retrieving the
    /// attachment. When
    /// set to `true`, the request is validated but no attachment content is
    /// returned, and
    /// the operation returns a `DryRunOperationException`. When omitted or set to
    /// `false`, the request runs normally.
    dry_run: ?bool = null,

    pub const json_field_names = .{
        .attachment_id = "attachmentId",
        .dry_run = "dryRun",
    };
};

pub const DescribeAttachmentOutput = struct {
    /// This object includes the attachment content and file name.
    ///
    /// In the previous response syntax, the value for the `data` parameter appears
    /// as `blob`, which is represented as a base64-encoded string. The value for
    /// `fileName` is the name of the attachment, such as
    /// `troubleshoot-screenshot.png`.
    attachment: ?Attachment = null,

    pub const json_field_names = .{
        .attachment = "attachment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAttachmentInput, options: CallOptions) !DescribeAttachmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAttachmentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.DescribeAttachment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAttachmentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAttachmentOutput, body, allocator);
}
