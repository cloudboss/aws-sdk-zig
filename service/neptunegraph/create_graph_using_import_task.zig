const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const BlankNodeHandling = @import("blank_node_handling.zig").BlankNodeHandling;
const Format = @import("format.zig").Format;
const ImportOptions = @import("import_options.zig").ImportOptions;
const ParquetType = @import("parquet_type.zig").ParquetType;
const VectorSearchConfiguration = @import("vector_search_configuration.zig").VectorSearchConfiguration;
const ImportTaskStatus = @import("import_task_status.zig").ImportTaskStatus;

pub const CreateGraphUsingImportTaskInput = struct {
    /// The method to handle blank nodes in the dataset. Currently, only
    /// `convertToIri` is supported, meaning blank nodes are converted to unique
    /// IRIs at load time. Must be provided when format is `ntriples`. For more
    /// information, see [Handling RDF
    /// values](https://docs.aws.amazon.com/neptune-analytics/latest/userguide/using-rdf-data.html#rdf-handling).
    blank_node_handling: ?BlankNodeHandling = null,

    /// Indicates whether or not to enable deletion protection on the graph. The
    /// graph can’t be deleted when deletion protection is enabled. (`true` or
    /// `false`).
    deletion_protection: ?bool = null,

    /// If set to `true`, the task halts when an import error is encountered. If set
    /// to `false`, the task skips the data that caused the error and continues if
    /// possible.
    fail_on_error: ?bool = null,

    /// Specifies the format of S3 data to be imported. Valid values are `CSV`,
    /// which identifies the [Gremlin CSV
    /// format](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format-gremlin.html), `OPEN_CYPHER`, which identifies the [openCypher load format](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format-opencypher.html), or `ntriples`, which identifies the [RDF n-triples](https://docs.aws.amazon.com/neptune-analytics/latest/userguide/using-rdf-data.html) format.
    format: ?Format = null,

    /// A name for the new Neptune Analytics graph to be created.
    ///
    /// The name must contain from 1 to 63 letters, numbers, or hyphens, and its
    /// first character must be a letter. It cannot end with a hyphen or contain two
    /// consecutive hyphens. Only lowercase letters are allowed.
    graph_name: []const u8,

    /// Contains options for controlling the import process. For example, if the
    /// `failOnError` key is set to `false`, the import skips problem data and
    /// attempts to continue (whereas if set to `true`, the default, or if omitted,
    /// the import operation halts immediately when an error is encountered.
    import_options: ?ImportOptions = null,

    /// Specifies a KMS key to use to encrypt data imported into the new graph.
    kms_key_identifier: ?[]const u8 = null,

    /// The maximum provisioned memory-optimized Neptune Capacity Units (m-NCUs) to
    /// use for the graph. Default: 1024, or the approved upper limit for your
    /// account.
    ///
    /// If both the minimum and maximum values are specified, the final
    /// `provisioned-memory` will be chosen per the actual size of your imported
    /// data. If neither value is specified, 128 m-NCUs are used.
    max_provisioned_memory: ?i32 = null,

    /// The minimum provisioned memory-optimized Neptune Capacity Units (m-NCUs) to
    /// use for the graph. Default: 16
    min_provisioned_memory: ?i32 = null,

    /// The parquet type of the import task.
    parquet_type: ?ParquetType = null,

    /// Specifies whether or not the graph can be reachable over the internet. All
    /// access to graphs is IAM authenticated. (`true` to enable, or `false` to
    /// disable).
    public_connectivity: ?bool = null,

    /// The number of replicas in other AZs to provision on the new graph after
    /// import. Default = 0, Min = 0, Max = 2.
    ///
    /// Additional charges equivalent to the m-NCUs selected for the graph apply for
    /// each replica.
    replica_count: ?i32 = null,

    /// The ARN of the IAM role that will allow access to the data that is to be
    /// imported.
    role_arn: []const u8,

    /// A URL identifying to the location of the data to be imported. This can be an
    /// Amazon S3 path, or can point to a Neptune database endpoint or snapshot.
    source: []const u8,

    /// Adds metadata tags to the new graph. These tags can also be used with cost
    /// allocation reporting, or used in a Condition statement in an IAM policy.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Specifies the number of dimensions for vector embeddings that will be loaded
    /// into the graph. The value is specified as `dimension=`value. Max = 65,535
    vector_search_configuration: ?VectorSearchConfiguration = null,

    pub const json_field_names = .{
        .blank_node_handling = "blankNodeHandling",
        .deletion_protection = "deletionProtection",
        .fail_on_error = "failOnError",
        .format = "format",
        .graph_name = "graphName",
        .import_options = "importOptions",
        .kms_key_identifier = "kmsKeyIdentifier",
        .max_provisioned_memory = "maxProvisionedMemory",
        .min_provisioned_memory = "minProvisionedMemory",
        .parquet_type = "parquetType",
        .public_connectivity = "publicConnectivity",
        .replica_count = "replicaCount",
        .role_arn = "roleArn",
        .source = "source",
        .tags = "tags",
        .vector_search_configuration = "vectorSearchConfiguration",
    };
};

pub const CreateGraphUsingImportTaskOutput = struct {
    /// Specifies the format of S3 data to be imported. Valid values are `CSV`,
    /// which identifies the [Gremlin CSV
    /// format](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format-gremlin.html), `OPENCYPHER`, which identifies the [openCypher load format](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format-opencypher.html), or `ntriples`, which identifies the [RDF n-triples](https://docs.aws.amazon.com/neptune-analytics/latest/userguide/using-rdf-data.html) format.
    format: ?Format = null,

    /// The unique identifier of the Neptune Analytics graph.
    graph_id: ?[]const u8 = null,

    /// Contains options for controlling the import process. For example, if the
    /// `failOnError` key is set to `false`, the import skips problem data and
    /// attempts to continue (whereas if set to `true`, the default, or if omitted,
    /// the import operation halts immediately when an error is encountered.
    import_options: ?ImportOptions = null,

    /// The parquet type of the import task.
    parquet_type: ?ParquetType = null,

    /// The ARN of the IAM role that will allow access to the data that is to be
    /// imported.
    role_arn: []const u8,

    /// A URL identifying to the location of the data to be imported. This can be an
    /// Amazon S3 path, or can point to a Neptune database endpoint or snapshot.
    source: []const u8,

    /// The status of the import task.
    status: ImportTaskStatus,

    /// The unique identifier of the import task.
    task_id: []const u8,

    pub const json_field_names = .{
        .format = "format",
        .graph_id = "graphId",
        .import_options = "importOptions",
        .parquet_type = "parquetType",
        .role_arn = "roleArn",
        .source = "source",
        .status = "status",
        .task_id = "taskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGraphUsingImportTaskInput, options: CallOptions) !CreateGraphUsingImportTaskOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGraphUsingImportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptunegraph", "Neptune Graph", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/importtasks";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.blank_node_handling) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"blankNodeHandling\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.deletion_protection) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deletionProtection\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.fail_on_error) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"failOnError\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.format) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"format\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"graphName\":");
    try aws.json.writeValue(@TypeOf(input.graph_name), input.graph_name, allocator, &body_buf);
    has_prev = true;
    if (input.import_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"importOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_provisioned_memory) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxProvisionedMemory\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.min_provisioned_memory) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"minProvisionedMemory\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parquet_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parquetType\":");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"source\":");
    try aws.json.writeValue(@TypeOf(input.source), input.source, allocator, &body_buf);
    has_prev = true;
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGraphUsingImportTaskOutput {
    var result: CreateGraphUsingImportTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateGraphUsingImportTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
