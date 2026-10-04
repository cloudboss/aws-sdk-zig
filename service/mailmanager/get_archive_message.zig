const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Envelope = @import("envelope.zig").Envelope;
const Metadata = @import("metadata.zig").Metadata;

pub const GetArchiveMessageInput = struct {
    /// The unique identifier of the archived email message.
    archived_message_id: []const u8,

    pub const json_field_names = .{
        .archived_message_id = "ArchivedMessageId",
    };
};

pub const GetArchiveMessageOutput = struct {
    /// The SMTP envelope information of the email.
    envelope: ?Envelope = null,

    /// A pre-signed URL to temporarily download the full message content.
    message_download_link: ?[]const u8 = null,

    /// The metadata about the email.
    metadata: ?Metadata = null,

    pub const json_field_names = .{
        .envelope = "Envelope",
        .message_download_link = "MessageDownloadLink",
        .metadata = "Metadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetArchiveMessageInput, options: CallOptions) !GetArchiveMessageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetArchiveMessageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mail-manager", "MailManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.GetArchiveMessage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetArchiveMessageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetArchiveMessageOutput, body, allocator);
}
