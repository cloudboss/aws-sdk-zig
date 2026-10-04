const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BackupPolicy = @import("backup_policy.zig").BackupPolicy;

pub const PutBackupPolicyInput = struct {
    /// The backup policy included in the `PutBackupPolicy` request.
    backup_policy: BackupPolicy,

    /// Specifies which EFS file system to update the backup policy for.
    file_system_id: []const u8,

    pub const json_field_names = .{
        .backup_policy = "BackupPolicy",
        .file_system_id = "FileSystemId",
    };
};

pub const PutBackupPolicyOutput = struct {
    /// Describes the file system's backup policy, indicating whether automatic
    /// backups are
    /// turned on or off.
    backup_policy: ?BackupPolicy = null,

    pub const json_field_names = .{
        .backup_policy = "BackupPolicy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutBackupPolicyInput, options: CallOptions) !PutBackupPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticfilesystem", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutBackupPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticfilesystem", "EFS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-02-01/file-systems/");
    try path_buf.appendSlice(allocator, input.file_system_id);
    try path_buf.appendSlice(allocator, "/backup-policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BackupPolicy\":");
    try aws.json.writeValue(@TypeOf(input.backup_policy), input.backup_policy, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutBackupPolicyOutput {
    const result: PutBackupPolicyOutput = try aws.json.parseJsonObject(
        PutBackupPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
