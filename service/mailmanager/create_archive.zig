const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ArchiveRetention = @import("archive_retention.zig").ArchiveRetention;
const Tag = @import("tag.zig").Tag;

pub const CreateArchiveInput = struct {
    /// A unique name for the new archive.
    archive_name: []const u8,

    /// A unique token Amazon SES uses to recognize retries of this request.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key for encrypting emails in the
    /// archive.
    kms_key_arn: ?[]const u8 = null,

    /// The period for retaining emails in the archive before automatic deletion.
    retention: ?ArchiveRetention = null,

    /// The tags used to organize, track, or control access for the resource. For
    /// example, { "tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .archive_name = "ArchiveName",
        .client_token = "ClientToken",
        .kms_key_arn = "KmsKeyArn",
        .retention = "Retention",
        .tags = "Tags",
    };
};

pub const CreateArchiveOutput = struct {
    /// The unique identifier for the newly created archive.
    archive_id: []const u8,

    pub const json_field_names = .{
        .archive_id = "ArchiveId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateArchiveInput, options: CallOptions) !CreateArchiveOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateArchiveInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.CreateArchive");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateArchiveOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateArchiveOutput, body, allocator);
}
