const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterSnapshot = @import("cluster_snapshot.zig").ClusterSnapshot;

pub const CreateClusterSnapshotInput = struct {
    /// The ARN identifier of the elastic cluster of which you want to create a
    /// snapshot.
    cluster_arn: []const u8,

    /// The name of the new elastic cluster snapshot.
    snapshot_name: []const u8,

    /// The tags to be assigned to the new elastic cluster snapshot.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cluster_arn = "clusterArn",
        .snapshot_name = "snapshotName",
        .tags = "tags",
    };
};

pub const CreateClusterSnapshotOutput = struct {
    /// Returns information about the new elastic cluster snapshot.
    snapshot: ?ClusterSnapshot = null,

    pub const json_field_names = .{
        .snapshot = "snapshot",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClusterSnapshotInput, options: CallOptions) !CreateClusterSnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "docdb-elastic", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateClusterSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("docdb-elastic", "DocDB Elastic", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/cluster-snapshot";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clusterArn\":");
    try aws.json.writeValue(@TypeOf(input.cluster_arn), input.cluster_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateClusterSnapshotOutput {
    const result: CreateClusterSnapshotOutput = try aws.json.parseJsonObject(
        CreateClusterSnapshotOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
