const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VectorSearchConfiguration = @import("vector_search_configuration.zig").VectorSearchConfiguration;
const GraphStatus = @import("graph_status.zig").GraphStatus;

pub const CreateGraphInput = struct {
    /// Indicates whether or not to enable deletion protection on the graph. The
    /// graph can’t be deleted when deletion protection is enabled. (`true` or
    /// `false`).
    deletion_protection: ?bool = null,

    /// A name for the new Neptune Analytics graph to be created.
    ///
    /// The name must contain from 1 to 63 letters, numbers, or hyphens, and its
    /// first character must be a letter. It cannot end with a hyphen or contain two
    /// consecutive hyphens. Only lowercase letters are allowed.
    graph_name: []const u8,

    /// Specifies a KMS key to use to encrypt data in the new graph.
    kms_key_identifier: ?[]const u8 = null,

    /// The provisioned memory-optimized Neptune Capacity Units (m-NCUs) to use for
    /// the graph. Min = 16
    provisioned_memory: i32,

    /// Specifies whether or not the graph can be reachable over the internet. All
    /// access to graphs is IAM authenticated. (`true` to enable, or `false` to
    /// disable.
    public_connectivity: ?bool = null,

    /// The number of replicas in other AZs. Min =0, Max = 2, Default = 1.
    ///
    /// Additional charges equivalent to the m-NCUs selected for the graph apply for
    /// each replica.
    replica_count: ?i32 = null,

    /// Adds metadata tags to the new graph. These tags can also be used with cost
    /// allocation reporting, or used in a Condition statement in an IAM policy.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Specifies the number of dimensions for vector embeddings that will be loaded
    /// into the graph. The value is specified as `dimension=`value. Max = 65,535
    vector_search_configuration: ?VectorSearchConfiguration = null,

    pub const json_field_names = .{
        .deletion_protection = "deletionProtection",
        .graph_name = "graphName",
        .kms_key_identifier = "kmsKeyIdentifier",
        .provisioned_memory = "provisionedMemory",
        .public_connectivity = "publicConnectivity",
        .replica_count = "replicaCount",
        .tags = "tags",
        .vector_search_configuration = "vectorSearchConfiguration",
    };
};

pub const CreateGraphOutput = struct {
    /// The ARN of the graph.
    arn: []const u8,

    /// The build number of the graph software.
    build_number: ?[]const u8 = null,

    /// The time when the graph was created.
    create_time: ?i64 = null,

    /// A value that indicates whether the graph has deletion protection enabled.
    /// The graph can't be deleted when deletion protection is enabled.
    deletion_protection: ?bool = null,

    /// The graph endpoint.
    endpoint: ?[]const u8 = null,

    /// The ID of the graph.
    id: []const u8,

    /// Specifies the KMS key used to encrypt data in the new graph.
    kms_key_identifier: ?[]const u8 = null,

    /// The graph name. For example: `my-graph-1`.
    ///
    /// The name must contain from 1 to 63 letters, numbers, or hyphens, and its
    /// first character must be a letter. It cannot end with a hyphen or contain two
    /// consecutive hyphens. Only lowercase letters are allowed.
    name: []const u8,

    /// The provisioned memory-optimized Neptune Capacity Units (m-NCUs) to use for
    /// the graph.
    ///
    /// Min = 16
    provisioned_memory: ?i32 = null,

    /// Specifies whether or not the graph can be reachable over the internet. All
    /// access to graphs is IAM authenticated.
    ///
    /// If enabling public connectivity for the first time, there will be a delay
    /// while it is enabled.
    public_connectivity: ?bool = null,

    /// The number of replicas in other AZs.
    ///
    /// Default: If not specified, the default value is 1.
    replica_count: ?i32 = null,

    /// The ID of the source graph.
    source_snapshot_id: ?[]const u8 = null,

    /// The current status of the graph.
    status: ?GraphStatus = null,

    /// The reason the status was given.
    status_reason: ?[]const u8 = null,

    /// The vector-search configuration for the graph, which specifies the vector
    /// dimension to use in the vector index, if any.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGraphInput, options: CallOptions) !CreateGraphOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGraphInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-graph", "Neptune Graph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/graphs";

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
    if (input.kms_key_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"provisionedMemory\":");
    try aws.json.writeValue(@TypeOf(input.provisioned_memory), input.provisioned_memory, allocator, &body_buf);
    has_prev = true;
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
    if (input.vector_search_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vectorSearchConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGraphOutput {
    const result: CreateGraphOutput = try aws.json.parseJsonObject(
        CreateGraphOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
