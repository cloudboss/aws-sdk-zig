const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IncrementalRunConfig = @import("incremental_run_config.zig").IncrementalRunConfig;
const InputSource = @import("input_source.zig").InputSource;
const OutputSource = @import("output_source.zig").OutputSource;
const ResolutionTechniques = @import("resolution_techniques.zig").ResolutionTechniques;

pub const UpdateMatchingWorkflowInput = struct {
    /// A description of the workflow.
    description: ?[]const u8 = null,

    /// Optional. An object that defines the incremental run type. This object
    /// contains only the `incrementalRunType` field, which appears as "Automatic"
    /// in the console.
    ///
    /// For workflows where `resolutionType` is `ML_MATCHING` or `PROVIDER`,
    /// incremental processing is not supported.
    incremental_run_config: ?IncrementalRunConfig = null,

    /// A list of `InputSource` objects, which have the fields `InputSourceARN` and
    /// `SchemaName`.
    input_source_config: []const InputSource,

    /// A list of `OutputSource` objects, each of which contains fields
    /// `outputS3Path`, `applyNormalization`, `KMSArn`, and `output`.
    output_source_config: []const OutputSource,

    /// An object which defines the `resolutionType` and the `ruleBasedProperties`.
    resolution_techniques: ResolutionTechniques,

    /// The Amazon Resource Name (ARN) of the IAM role. Entity Resolution assumes
    /// this role to create resources on your behalf as part of workflow execution.
    role_arn: []const u8,

    /// The name of the workflow to be retrieved.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .incremental_run_config = "incrementalRunConfig",
        .input_source_config = "inputSourceConfig",
        .output_source_config = "outputSourceConfig",
        .resolution_techniques = "resolutionTechniques",
        .role_arn = "roleArn",
        .workflow_name = "workflowName",
    };
};

pub const UpdateMatchingWorkflowOutput = struct {
    /// A description of the workflow.
    description: ?[]const u8 = null,

    /// An object which defines an incremental run type and has only
    /// `incrementalRunType` as a field.
    incremental_run_config: ?IncrementalRunConfig = null,

    /// A list of `InputSource` objects, which have the fields `InputSourceARN` and
    /// `SchemaName`.
    input_source_config: ?[]const InputSource = null,

    /// A list of `OutputSource` objects, each of which contains fields
    /// `outputS3Path`, `applyNormalization`, `KMSArn`, and `output`.
    output_source_config: ?[]const OutputSource = null,

    /// An object which defines the `resolutionType` and the `ruleBasedProperties`.
    resolution_techniques: ?ResolutionTechniques = null,

    /// The Amazon Resource Name (ARN) of the IAM role. Entity Resolution assumes
    /// this role to create resources on your behalf as part of workflow execution.
    role_arn: []const u8,

    /// The name of the workflow.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .incremental_run_config = "incrementalRunConfig",
        .input_source_config = "inputSourceConfig",
        .output_source_config = "outputSourceConfig",
        .resolution_techniques = "resolutionTechniques",
        .role_arn = "roleArn",
        .workflow_name = "workflowName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMatchingWorkflowInput, options: Options) !UpdateMatchingWorkflowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "entityresolution");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMatchingWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/matchingworkflows/");
    try path_buf.appendSlice(allocator, input.workflow_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.incremental_run_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"incrementalRunConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"inputSourceConfig\":");
    try aws.json.writeValue(@TypeOf(input.input_source_config), input.input_source_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outputSourceConfig\":");
    try aws.json.writeValue(@TypeOf(input.output_source_config), input.output_source_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resolutionTechniques\":");
    try aws.json.writeValue(@TypeOf(input.resolution_techniques), input.resolution_techniques, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMatchingWorkflowOutput {
    var result: UpdateMatchingWorkflowOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateMatchingWorkflowOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ExceedsLimitException")) {
        return .{ .arena = arena, .kind = .{ .exceeds_limit_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
