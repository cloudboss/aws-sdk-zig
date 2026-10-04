const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ArchiveState = @import("archive_state.zig").ArchiveState;
const ArchiveRetention = @import("archive_retention.zig").ArchiveRetention;

pub const GetArchiveInput = struct {
    /// The identifier of the archive to retrieve.
    archive_id: []const u8,

    pub const json_field_names = .{
        .archive_id = "ArchiveId",
    };
};

pub const GetArchiveOutput = struct {
    /// The Amazon Resource Name (ARN) of the archive.
    archive_arn: []const u8,

    /// The unique identifier of the archive.
    archive_id: []const u8,

    /// The unique name assigned to the archive.
    archive_name: []const u8,

    /// The current state of the archive:
    ///
    /// * `ACTIVE` – The archive is ready and available for use.
    /// * `PENDING_DELETION` – The archive has been marked for deletion and will be
    ///   permanently deleted in 30 days. No further modifications can be made in
    ///   this state.
    archive_state: ArchiveState,

    /// The timestamp of when the archive was created.
    created_timestamp: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the archive.
    kms_key_arn: ?[]const u8 = null,

    /// The timestamp of when the archive was modified.
    last_updated_timestamp: ?i64 = null,

    /// The retention period for emails in this archive.
    retention: ?ArchiveRetention = null,

    pub const json_field_names = .{
        .archive_arn = "ArchiveArn",
        .archive_id = "ArchiveId",
        .archive_name = "ArchiveName",
        .archive_state = "ArchiveState",
        .created_timestamp = "CreatedTimestamp",
        .kms_key_arn = "KmsKeyArn",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .retention = "Retention",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetArchiveInput, options: CallOptions) !GetArchiveOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetArchiveInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.GetArchive");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetArchiveOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetArchiveOutput, body, allocator);
}
