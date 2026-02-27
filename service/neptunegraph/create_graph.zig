const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGraphInput, options: Options) !CreateGraphOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "neptunegraph");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateGraphInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptunegraph", "Neptune Graph", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/graphs";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.deletion_protection) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"deletionProtection\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"graphName\":");
    try aws.json.writeValue(@TypeOf(input.graph_name), input.graph_name, alloc, &body_buf);
    has_prev = true;
    if (input.kms_key_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"kmsKeyIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"provisionedMemory\":");
    try aws.json.writeValue(@TypeOf(input.provisioned_memory), input.provisioned_memory, alloc, &body_buf);
    has_prev = true;
    if (input.public_connectivity) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"publicConnectivity\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.replica_count) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"replicaCount\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.vector_search_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"vectorSearchConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateGraphOutput {
    var result: CreateGraphOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateGraphOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnprocessableException")) {
        return .{ .arena = arena, .kind = .{ .unprocessable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
