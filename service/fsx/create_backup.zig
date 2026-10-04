const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Backup = @import("backup.zig").Backup;

pub const CreateBackupInput = struct {
    /// (Optional) A string of up to 63 ASCII characters that Amazon FSx uses to
    /// ensure idempotent creation. This string is automatically filled on your
    /// behalf when you
    /// use the Command Line Interface (CLI) or an Amazon Web Services SDK.
    client_request_token: ?[]const u8 = null,

    /// The ID of the file system to back up.
    file_system_id: ?[]const u8 = null,

    /// (Optional) The tags to apply to the backup at backup creation. The key value
    /// of the
    /// `Name` tag appears in the console as the backup name. If you have set
    /// `CopyTagsToBackups` to `true`, and you specify one or more
    /// tags using the `CreateBackup` operation, no existing file system tags are
    /// copied from the file system to the backup.
    tags: ?[]const Tag = null,

    /// (Optional) The ID of the FSx for ONTAP volume to back up.
    volume_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .file_system_id = "FileSystemId",
        .tags = "Tags",
        .volume_id = "VolumeId",
    };
};

pub const CreateBackupOutput = struct {
    /// A description of the backup.
    backup: ?Backup = null,

    pub const json_field_names = .{
        .backup = "Backup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBackupInput, options: CallOptions) !CreateBackupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fsx", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBackupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fsx", "FSx", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CreateBackup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBackupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateBackupOutput, body, allocator);
}
