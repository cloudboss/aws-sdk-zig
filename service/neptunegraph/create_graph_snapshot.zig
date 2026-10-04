const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SnapshotStatus = @import("snapshot_status.zig").SnapshotStatus;

pub const CreateGraphSnapshotInput = struct {
    /// The unique identifier of the Neptune Analytics graph.
    graph_identifier: []const u8,

    /// The snapshot name. For example: `my-snapshot-1`.
    ///
    /// The name must contain from 1 to 63 letters, numbers, or hyphens, and its
    /// first character must be a letter. It cannot end with a hyphen or contain two
    /// consecutive hyphens. Only lowercase letters are allowed.
    snapshot_name: []const u8,

    /// Adds metadata tags to the new graph. These tags can also be used with cost
    /// allocation reporting, or used in a Condition statement in an IAM policy.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .graph_identifier = "graphIdentifier",
        .snapshot_name = "snapshotName",
        .tags = "tags",
    };
};

pub const CreateGraphSnapshotOutput = struct {
    /// The ARN of the snapshot created.
    arn: []const u8,

    /// The ID of the snapshot created.
    id: []const u8,

    /// The ID of the KMS key used to encrypt and decrypt graph data.
    kms_key_identifier: ?[]const u8 = null,

    /// The name of the snapshot created.
    name: []const u8,

    /// The snapshot creation time
    snapshot_create_time: ?i64 = null,

    /// The Id of the Neptune Analytics graph from which the snapshot is created.
    source_graph_id: ?[]const u8 = null,

    /// The current state of the snapshot.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGraphSnapshotInput, options: CallOptions) !CreateGraphSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGraphSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-graph", "Neptune Graph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/snapshots";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"graphIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.graph_identifier), input.graph_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"snapshotName\":");
    try aws.json.writeValue(@TypeOf(input.snapshot_name), input.snapshot_name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGraphSnapshotOutput {
    var result: CreateGraphSnapshotOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateGraphSnapshotOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
