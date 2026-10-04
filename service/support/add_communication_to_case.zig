const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AddCommunicationToCaseInput = struct {
    /// The ID of a set of one or more attachments for the communication to add to
    /// the case.
    /// Create the set by calling AddAttachmentsToSet. Each attachment in the
    /// set must be 5 MB or smaller. To attach files larger than 5 MB, use
    /// `uploadIds`.
    attachment_set_id: ?[]const u8 = null,

    /// The support case ID requested or returned in the call. The case ID is an
    /// alphanumeric
    /// string formatted as shown in this example:
    /// case-*12345678910-exen-2025-c4c1d2bf33c5cf47*
    case_id: ?[]const u8 = null,

    /// The email addresses in the CC line of an email to be added to the support
    /// case.
    cc_email_addresses: ?[]const []const u8 = null,

    /// The body of an email communication to add to the support case.
    communication_body: []const u8,

    /// Specifies whether to validate the request without actually adding the
    /// communication to the
    /// case. When set to `true`, the request is validated but the communication
    /// isn't
    /// added, and the operation returns a `DryRunOperationException`. When omitted
    /// or set
    /// to `false`, the request runs normally.
    dry_run: ?bool = null,

    /// A list of upload IDs that identify attachments to add to the case. Each
    /// `uploadId` is returned by the GetAttachmentUploadLinks
    /// operation. The upload must reach the `attachment-ready` state by calling
    /// CompleteAttachmentUpload before it can be passed here.
    /// Use
    /// `uploadIds` to attach files of any supported size, including files larger
    /// than
    /// 5 MB.
    upload_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .attachment_set_id = "attachmentSetId",
        .case_id = "caseId",
        .cc_email_addresses = "ccEmailAddresses",
        .communication_body = "communicationBody",
        .dry_run = "dryRun",
        .upload_ids = "uploadIds",
    };
};

pub const AddCommunicationToCaseOutput = struct {
    /// True if AddCommunicationToCase succeeds. Otherwise, returns an
    /// error.
    result: ?bool = null,

    pub const json_field_names = .{
        .result = "result",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddCommunicationToCaseInput, options: CallOptions) !AddCommunicationToCaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddCommunicationToCaseInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.AddCommunicationToCase");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddCommunicationToCaseOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AddCommunicationToCaseOutput, body, allocator);
}
