const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const AttachmentStatus = @import("attachment_status.zig").AttachmentStatus;

pub const CreateRegistrationAttachmentInput = struct {
    /// The registration file to upload. The maximum file size is 500KB and valid
    /// file extensions are PDF, JPEG and PNG.
    attachment_body: ?[]const u8 = null,

    /// Registration files have to be stored in an Amazon S3 bucket. The URI to use
    /// when sending is in the format `s3://BucketName/FileName`.
    attachment_url: ?[]const u8 = null,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. If you don't specify a client token, a randomly generated
    /// token is used for the request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// An array of tags (key and value pairs) to associate with the registration
    /// attachment.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .attachment_body = "AttachmentBody",
        .attachment_url = "AttachmentUrl",
        .client_token = "ClientToken",
        .tags = "Tags",
    };
};

pub const CreateRegistrationAttachmentOutput = struct {
    /// The status of the registration attachment.
    ///
    /// * `UPLOAD_IN_PROGRESS` The attachment is being uploaded.
    /// * `UPLOAD_COMPLETE` The attachment has been uploaded.
    /// * `UPLOAD_FAILED` The attachment failed to uploaded.
    /// * `DELETED` The attachment has been deleted..
    attachment_status: AttachmentStatus,

    /// The time when the registration attachment was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The Amazon Resource Name (ARN) for the registration attachment.
    registration_attachment_arn: []const u8,

    /// The unique identifier for the registration attachment.
    registration_attachment_id: []const u8,

    /// An array of tags (key and value pairs) to associate with the registration
    /// attachment.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .attachment_status = "AttachmentStatus",
        .created_timestamp = "CreatedTimestamp",
        .registration_attachment_arn = "RegistrationAttachmentArn",
        .registration_attachment_id = "RegistrationAttachmentId",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRegistrationAttachmentInput, options: CallOptions) !CreateRegistrationAttachmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRegistrationAttachmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.CreateRegistrationAttachment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRegistrationAttachmentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateRegistrationAttachmentOutput, body, allocator);
}
