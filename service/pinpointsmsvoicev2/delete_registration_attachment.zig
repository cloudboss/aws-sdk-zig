const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttachmentStatus = @import("attachment_status.zig").AttachmentStatus;
const AttachmentUploadErrorReason = @import("attachment_upload_error_reason.zig").AttachmentUploadErrorReason;

pub const DeleteRegistrationAttachmentInput = struct {
    /// The unique identifier for the registration attachment.
    registration_attachment_id: []const u8,

    pub const json_field_names = .{
        .registration_attachment_id = "RegistrationAttachmentId",
    };
};

pub const DeleteRegistrationAttachmentOutput = struct {
    /// The status of the registration attachment.
    ///
    /// * `UPLOAD_IN_PROGRESS` The attachment is being uploaded.
    /// * `UPLOAD_COMPLETE` The attachment has been uploaded.
    /// * `UPLOAD_FAILED` The attachment failed to uploaded.
    /// * `DELETED` The attachment has been deleted..
    attachment_status: AttachmentStatus,

    /// The error message if the upload failed.
    attachment_upload_error_reason: ?AttachmentUploadErrorReason = null,

    /// The time when the registration attachment was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The Amazon Resource Name (ARN) for the registration attachment.
    registration_attachment_arn: []const u8,

    /// The unique identifier for the registration attachment.
    registration_attachment_id: []const u8,

    pub const json_field_names = .{
        .attachment_status = "AttachmentStatus",
        .attachment_upload_error_reason = "AttachmentUploadErrorReason",
        .created_timestamp = "CreatedTimestamp",
        .registration_attachment_arn = "RegistrationAttachmentArn",
        .registration_attachment_id = "RegistrationAttachmentId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteRegistrationAttachmentInput, options: CallOptions) !DeleteRegistrationAttachmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteRegistrationAttachmentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.DeleteRegistrationAttachment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteRegistrationAttachmentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DeleteRegistrationAttachmentOutput, body, allocator);
}
