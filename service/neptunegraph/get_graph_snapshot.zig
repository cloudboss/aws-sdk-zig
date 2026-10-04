const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SnapshotStatus = @import("snapshot_status.zig").SnapshotStatus;

pub const GetGraphSnapshotInput = struct {
    /// The ID of the snapshot to retrieve.
    snapshot_identifier: []const u8,

    pub const json_field_names = .{
        .snapshot_identifier = "snapshotIdentifier",
    };
};

pub const GetGraphSnapshotOutput = struct {
    /// The ARN of the graph snapshot.
    arn: []const u8,

    /// The unique identifier of the graph snapshot.
    id: []const u8,

    /// The ID of the KMS key used to encrypt and decrypt the snapshot.
    kms_key_identifier: ?[]const u8 = null,

    /// The snapshot name. For example: `my-snapshot-1`.
    ///
    /// The name must contain from 1 to 63 letters, numbers, or hyphens, and its
    /// first character must be a letter. It cannot end with a hyphen or contain two
    /// consecutive hyphens. Only lowercase letters are allowed.
    name: []const u8,

    /// The time when the snapshot was created.
    snapshot_create_time: ?i64 = null,

    /// The graph identifier for the graph for which a snapshot is to be created.
    source_graph_id: ?[]const u8 = null,

    /// The status of the graph snapshot.
    status: ?SnapshotStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .kms_key_identifier = "kmsKeyIdentifier",
        .name = "name",
        .snapshot_create_time = "snapshotCreateTime",
        .source_graph_id = "sourceGraphId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGraphSnapshotInput, options: CallOptions) !GetGraphSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-graph", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGraphSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-graph", "Neptune Graph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/snapshots/");
    try path_buf.appendSlice(allocator, input.snapshot_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGraphSnapshotOutput {
    var result: GetGraphSnapshotOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetGraphSnapshotOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
