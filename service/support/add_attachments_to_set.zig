const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Attachment = @import("attachment.zig").Attachment;

pub const AddAttachmentsToSetInput = struct {
    /// One or more attachments to add to the set. You can add up to three
    /// attachments per
    /// set. The size limit is 5 MB per attachment.
    ///
    /// In the `Attachment` object, use the `data` parameter to specify
    /// the contents of the attachment file. In the previous request syntax, the
    /// value for
    /// `data` appear as `blob`, which is represented as a
    /// base64-encoded string. The value for `fileName` is the name of the
    /// attachment, such as `troubleshoot-screenshot.png`.
    attachments: []const Attachment,

    /// The ID of the attachment set. If an `attachmentSetId` is not specified, a
    /// new attachment set is created, and the ID of the set is returned in the
    /// response. If an
    /// `attachmentSetId` is specified, the attachments are added to the
    /// specified set, if it exists.
    attachment_set_id: ?[]const u8 = null,

    /// Specifies whether to validate the request without actually adding the
    /// attachments. When set
    /// to `true`, the request is validated but no attachments are stored, and the
    /// operation
    /// returns a `DryRunOperationException`. When omitted or set to `false`, the
    /// request runs normally.
    dry_run: ?bool = null,

    pub const json_field_names = .{
        .attachments = "attachments",
        .attachment_set_id = "attachmentSetId",
        .dry_run = "dryRun",
    };
};

pub const AddAttachmentsToSetOutput = struct {
    /// The ID of the attachment set. If an `attachmentSetId` was not specified, a
    /// new attachment set is created, and the ID of the set is returned in the
    /// response. If an
    /// `attachmentSetId` was specified, the attachments are added to the
    /// specified set, if it exists.
    attachment_set_id: ?[]const u8 = null,

    /// The time and date when the attachment set expires.
    expiry_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachment_set_id = "attachmentSetId",
        .expiry_time = "expiryTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddAttachmentsToSetInput, options: CallOptions) !AddAttachmentsToSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddAttachmentsToSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.AddAttachmentsToSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddAttachmentsToSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AddAttachmentsToSetOutput, body, allocator);
}
