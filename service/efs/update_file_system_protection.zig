const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplicationOverwriteProtection = @import("replication_overwrite_protection.zig").ReplicationOverwriteProtection;

pub const UpdateFileSystemProtectionInput = struct {
    /// The ID of the file system to update.
    file_system_id: []const u8,

    /// The status of the file system's replication overwrite protection.
    ///
    /// * `ENABLED` – The file system cannot be used as the destination file
    /// system in a replication configuration. The file system is writeable.
    /// Replication overwrite
    /// protection is `ENABLED` by default.
    ///
    /// * `DISABLED` – The file system can be used as the destination file
    /// system in a replication configuration. The file system is read-only and can
    /// only be
    /// modified by EFS replication.
    ///
    /// * `REPLICATING` – The file system is being used as the destination file
    /// system in a replication configuration. The file system is read-only and is
    /// only modified
    /// only by EFS replication.
    ///
    /// If the replication configuration is deleted, the file system's replication
    /// overwrite
    /// protection is re-enabled and the file system becomes writeable.
    replication_overwrite_protection: ?ReplicationOverwriteProtection = null,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .replication_overwrite_protection = "ReplicationOverwriteProtection",
    };
};

pub const UpdateFileSystemProtectionOutput = @import("file_system_protection_description.zig").FileSystemProtectionDescription;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFileSystemProtectionInput, options: CallOptions) !UpdateFileSystemProtectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFileSystemProtectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticfilesystem", "EFS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-02-01/file-systems/");
    try path_buf.appendSlice(allocator, input.file_system_id);
    try path_buf.appendSlice(allocator, "/protection");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.replication_overwrite_protection) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReplicationOverwriteProtection\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFileSystemProtectionOutput {
    const result: UpdateFileSystemProtectionOutput = try aws.json.parseJsonObject(
        UpdateFileSystemProtectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
