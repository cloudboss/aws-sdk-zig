const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GraphStatus = @import("graph_status.zig").GraphStatus;
const VectorSearchConfiguration = @import("vector_search_configuration.zig").VectorSearchConfiguration;

pub const DeleteGraphInput = struct {
    /// The unique identifier of the Neptune Analytics graph.
    graph_identifier: []const u8,

    /// Determines whether a final graph snapshot is created before the graph is
    /// deleted. If `true` is specified, no graph snapshot is created. If `false` is
    /// specified, a graph snapshot is created before the graph is deleted.
    skip_snapshot: bool,

    pub const json_field_names = .{
        .graph_identifier = "graphIdentifier",
        .skip_snapshot = "skipSnapshot",
    };
};

pub const DeleteGraphOutput = struct {
    /// The ARN associated with the graph.
    arn: []const u8,

    /// The build number associated with the graph.
    build_number: ?[]const u8 = null,

    /// The time at which the graph was created.
    create_time: ?i64 = null,

    /// If `true`, deletion protection was enabled for the graph.
    deletion_protection: ?bool = null,

    /// The graph endpoint.
    endpoint: ?[]const u8 = null,

    /// The unique identifier of the graph.
    id: []const u8,

    /// The ID of the KMS key used to encrypt and decrypt graph data.
    kms_key_identifier: ?[]const u8 = null,

    /// The name of the graph.
    name: []const u8,

    /// The number of memory-optimized Neptune Capacity Units (m-NCUs) allocated to
    /// the graph.
    provisioned_memory: ?i32 = null,

    /// If `true`, the graph has a public endpoint, otherwise not.
    public_connectivity: ?bool = null,

    /// The number of replicas for the graph.
    replica_count: ?i32 = null,

    /// The ID of the snapshot from which the graph was created, if the graph was
    /// recovered from a snapshot.
    source_snapshot_id: ?[]const u8 = null,

    /// The status of the graph.
    status: ?GraphStatus = null,

    /// The reason for the status of the graph.
    status_reason: ?[]const u8 = null,

    vector_search_configuration: ?VectorSearchConfiguration = null,

    pub const json_field_names = .{
        .arn = "arn",
        .build_number = "buildNumber",
        .create_time = "createTime",
        .deletion_protection = "deletionProtection",
        .endpoint = "endpoint",
        .id = "id",
        .kms_key_identifier = "kmsKeyIdentifier",
        .name = "name",
        .provisioned_memory = "provisionedMemory",
        .public_connectivity = "publicConnectivity",
        .replica_count = "replicaCount",
        .source_snapshot_id = "sourceSnapshotId",
        .status = "status",
        .status_reason = "statusReason",
        .vector_search_configuration = "vectorSearchConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteGraphInput, options: CallOptions) !DeleteGraphOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteGraphInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-graph", "Neptune Graph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/graphs/");
    try path_buf.appendSlice(allocator, input.graph_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "skipSnapshot=");
    try query_buf.appendSlice(allocator, if (input.skip_snapshot) "true" else "false");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteGraphOutput {
    var result: DeleteGraphOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteGraphOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
