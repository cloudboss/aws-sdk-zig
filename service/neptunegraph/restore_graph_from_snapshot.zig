const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GraphStatus = @import("graph_status.zig").GraphStatus;
const VectorSearchConfiguration = @import("vector_search_configuration.zig").VectorSearchConfiguration;

pub const RestoreGraphFromSnapshotInput = struct {
    /// A value that indicates whether the graph has deletion protection enabled.
    /// The graph can't be deleted when deletion protection is enabled.
    deletion_protection: ?bool = null,

    /// A name for the new Neptune Analytics graph to be created from the snapshot.
    ///
    /// The name must contain from 1 to 63 letters, numbers, or hyphens, and its
    /// first character must be a letter. It cannot end with a hyphen or contain two
    /// consecutive hyphens. Only lowercase letters are allowed.
    graph_name: []const u8,

    /// The provisioned memory-optimized Neptune Capacity Units (m-NCUs) to use for
    /// the graph.
    ///
    /// Min = 16
    provisioned_memory: ?i32 = null,

    /// Specifies whether or not the graph can be reachable over the internet. All
    /// access to graphs is IAM authenticated. (`true` to enable, or `false` to
    /// disable).
    public_connectivity: ?bool = null,

    /// The number of replicas in other AZs. Min =0, Max = 2, Default =1
    ///
    /// Additional charges equivalent to the m-NCUs selected for the graph apply for
    /// each replica.
    replica_count: ?i32 = null,

    /// The ID of the snapshot in question.
    snapshot_identifier: []const u8,

    /// Adds metadata tags to the snapshot. These tags can also be used with cost
    /// allocation reporting, or used in a Condition statement in an IAM policy.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .deletion_protection = "deletionProtection",
        .graph_name = "graphName",
        .provisioned_memory = "provisionedMemory",
        .public_connectivity = "publicConnectivity",
        .replica_count = "replicaCount",
        .snapshot_identifier = "snapshotIdentifier",
        .tags = "tags",
    };
};

pub const RestoreGraphFromSnapshotOutput = struct {
    /// The ARN associated with the graph.
    arn: []const u8,

    /// The build number of the graph.
    build_number: ?[]const u8 = null,

    /// The time at which the graph was created.
    create_time: ?i64 = null,

    /// If `true`, deletion protection is enabled for the graph.
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

    /// The ID of the snapshot from which the graph was created, if any.
    source_snapshot_id: ?[]const u8 = null,

    /// The status of the graph.
    status: ?GraphStatus = null,

    /// The reason that the graph has this status.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreGraphFromSnapshotInput, options: CallOptions) !RestoreGraphFromSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreGraphFromSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-graph", "Neptune Graph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/snapshots/");
    try path_buf.appendSlice(allocator, input.snapshot_identifier);
    try path_buf.appendSlice(allocator, "/restore");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.deletion_protection) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deletionProtection\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"graphName\":");
    try aws.json.writeValue(@TypeOf(input.graph_name), input.graph_name, allocator, &body_buf);
    has_prev = true;
    if (input.provisioned_memory) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"provisionedMemory\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.public_connectivity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"publicConnectivity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.replica_count) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"replicaCount\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreGraphFromSnapshotOutput {
    var result: RestoreGraphFromSnapshotOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RestoreGraphFromSnapshotOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
