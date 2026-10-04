const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Snapshot = @import("snapshot.zig").Snapshot;

pub const UpdateSnapshotInput = struct {
    client_request_token: ?[]const u8 = null,

    /// The name of the snapshot to update.
    name: []const u8,

    /// The ID of the snapshot that you want to update, in the format
    /// `fsvolsnap-0123456789abcdef0`.
    snapshot_id: []const u8,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .name = "Name",
        .snapshot_id = "SnapshotId",
    };
};

pub const UpdateSnapshotOutput = struct {
    /// Returned after a successful `UpdateSnapshot` operation, describing the
    /// snapshot that you updated.
    snapshot: ?Snapshot = null,

    pub const json_field_names = .{
        .snapshot = "Snapshot",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSnapshotInput, options: CallOptions) !UpdateSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSnapshotInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.UpdateSnapshot");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSnapshotOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateSnapshotOutput, body, allocator);
}
