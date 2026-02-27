const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BlankNodeHandling = @import("blank_node_handling.zig").BlankNodeHandling;
const Format = @import("format.zig").Format;
const ImportOptions = @import("import_options.zig").ImportOptions;
const ParquetType = @import("parquet_type.zig").ParquetType;
const ImportTaskStatus = @import("import_task_status.zig").ImportTaskStatus;

pub const StartImportTaskInput = struct {
    /// The method to handle blank nodes in the dataset. Currently, only
    /// `convertToIri` is supported, meaning blank nodes are converted to unique
    /// IRIs at load time. Must be provided when format is `ntriples`. For more
    /// information, see [Handling RDF
    /// values](https://docs.aws.amazon.com/neptune-analytics/latest/userguide/using-rdf-data.html#rdf-handling).
    blank_node_handling: ?BlankNodeHandling = null,

    /// If set to true, the task halts when an import error is encountered. If set
    /// to false, the task skips the data that caused the error and continues if
    /// possible.
    fail_on_error: ?bool = null,

    /// Specifies the format of Amazon S3 data to be imported. Valid values are CSV,
    /// which identifies the Gremlin CSV format or OPENCYPHER, which identifies the
    /// openCypher load format.
    format: ?Format = null,

    /// The unique identifier of the Neptune Analytics graph.
    graph_identifier: []const u8,

    import_options: ?ImportOptions = null,

    /// The parquet type of the import task.
    parquet_type: ?ParquetType = null,

    /// The ARN of the IAM role that will allow access to the data that is to be
    /// imported.
    role_arn: []const u8,

    /// A URL identifying the location of the data to be imported. This can be an
    /// Amazon S3 path, or can point to a Neptune database endpoint or snapshot.
    source: []const u8,

    pub const json_field_names = .{
        .blank_node_handling = "blankNodeHandling",
        .fail_on_error = "failOnError",
        .format = "format",
        .graph_identifier = "graphIdentifier",
        .import_options = "importOptions",
        .parquet_type = "parquetType",
        .role_arn = "roleArn",
        .source = "source",
    };
};

pub const StartImportTaskOutput = struct {
    /// Specifies the format of Amazon S3 data to be imported. Valid values are CSV,
    /// which identifies the Gremlin CSV format or OPENCYPHER, which identifies the
    /// openCypher load format.
    format: ?Format = null,

    /// The unique identifier of the Neptune Analytics graph.
    graph_id: ?[]const u8 = null,

    import_options: ?ImportOptions = null,

    /// The parquet type of the import task.
    parquet_type: ?ParquetType = null,

    /// The ARN of the IAM role that will allow access to the data that is to be
    /// imported.
    role_arn: []const u8,

    /// A URL identifying the location of the data to be imported. This can be an
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartImportTaskInput, options: Options) !StartImportTaskOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: StartImportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptunegraph", "Neptune Graph", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/graphs/");
    try path_buf.appendSlice(alloc, input.graph_identifier);
    try path_buf.appendSlice(alloc, "/importtasks");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.blank_node_handling) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"blankNodeHandling\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.fail_on_error) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"failOnError\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.format) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"format\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.import_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"importOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.parquet_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"parquetType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"source\":");
    try aws.json.writeValue(@TypeOf(input.source), input.source, alloc, &body_buf);
    has_prev = true;

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartImportTaskOutput {
    var result: StartImportTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartImportTaskOutput, body, alloc);
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
