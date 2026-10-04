const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetRestoreJobMetadataInput = struct {
    /// This is a unique identifier of a restore job within Backup.
    restore_job_id: []const u8,

    pub const json_field_names = .{
        .restore_job_id = "RestoreJobId",
    };
};

pub const GetRestoreJobMetadataOutput = struct {
    /// This contains the metadata of the specified backup job.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// This is a unique identifier of a restore job within Backup.
    restore_job_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .metadata = "Metadata",
        .restore_job_id = "RestoreJobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRestoreJobMetadataInput, options: CallOptions) !GetRestoreJobMetadataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRestoreJobMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restore-jobs/");
    try path_buf.appendSlice(allocator, input.restore_job_id);
    try path_buf.appendSlice(allocator, "/metadata");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRestoreJobMetadataOutput {
    const result: GetRestoreJobMetadataOutput = try aws.json.parseJsonObject(
        GetRestoreJobMetadataOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
