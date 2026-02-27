const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IdMappingTechniques = @import("id_mapping_techniques.zig").IdMappingTechniques;
const IdMappingIncrementalRunConfig = @import("id_mapping_incremental_run_config.zig").IdMappingIncrementalRunConfig;
const IdMappingWorkflowInputSource = @import("id_mapping_workflow_input_source.zig").IdMappingWorkflowInputSource;
const IdMappingWorkflowOutputSource = @import("id_mapping_workflow_output_source.zig").IdMappingWorkflowOutputSource;

pub const CreateIdMappingWorkflowInput = struct {
    /// A description of the workflow.
    description: ?[]const u8 = null,

    /// An object which defines the ID mapping technique and any additional
    /// configurations.
    id_mapping_techniques: IdMappingTechniques,

    /// The incremental run configuration for the ID mapping workflow.
    incremental_run_config: ?IdMappingIncrementalRunConfig = null,

    /// A list of `InputSource` objects, which have the fields `InputSourceARN` and
    /// `SchemaName`.
    input_source_config: []const IdMappingWorkflowInputSource,

    /// A list of `IdMappingWorkflowOutputSource` objects, each of which contains
    /// fields `outputS3Path` and `KMSArn`.
    output_source_config: ?[]const IdMappingWorkflowOutputSource = null,

    /// The Amazon Resource Name (ARN) of the IAM role. Entity Resolution assumes
    /// this role to create resources on your behalf as part of workflow execution.
    role_arn: []const u8 = "",

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The name of the workflow. There can't be multiple `IdMappingWorkflows` with
    /// the same name.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .id_mapping_techniques = "idMappingTechniques",
        .incremental_run_config = "incrementalRunConfig",
        .input_source_config = "inputSourceConfig",
        .output_source_config = "outputSourceConfig",
        .role_arn = "roleArn",
        .tags = "tags",
        .workflow_name = "workflowName",
    };
};

pub const CreateIdMappingWorkflowOutput = struct {
    /// A description of the workflow.
    description: ?[]const u8 = null,

    /// An object which defines the ID mapping technique and any additional
    /// configurations.
    id_mapping_techniques: ?IdMappingTechniques = null,

    /// The incremental run configuration for the ID mapping workflow.
    incremental_run_config: ?IdMappingIncrementalRunConfig = null,

    /// A list of `InputSource` objects, which have the fields `InputSourceARN` and
    /// `SchemaName`.
    input_source_config: ?[]const IdMappingWorkflowInputSource = null,

    /// A list of `IdMappingWorkflowOutputSource` objects, each of which contains
    /// fields `outputS3Path` and `KMSArn`.
    output_source_config: ?[]const IdMappingWorkflowOutputSource = null,

    /// The Amazon Resource Name (ARN) of the IAM role. Entity Resolution assumes
    /// this role to create resources on your behalf as part of workflow execution.
    role_arn: []const u8 = "",

    /// The ARN (Amazon Resource Name) that Entity Resolution generated for the
    /// `IDMappingWorkflow`.
    workflow_arn: []const u8,

    /// The name of the workflow.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .id_mapping_techniques = "idMappingTechniques",
        .incremental_run_config = "incrementalRunConfig",
        .input_source_config = "inputSourceConfig",
        .output_source_config = "outputSourceConfig",
        .role_arn = "roleArn",
        .workflow_arn = "workflowArn",
        .workflow_name = "workflowName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIdMappingWorkflowInput, options: Options) !CreateIdMappingWorkflowOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateIdMappingWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/idmappingworkflows";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"idMappingTechniques\":");
    try aws.json.writeValue(@TypeOf(input.id_mapping_techniques), input.id_mapping_techniques, alloc, &body_buf);
    has_prev = true;
    if (input.incremental_run_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"incrementalRunConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"inputSourceConfig\":");
    try aws.json.writeValue(@TypeOf(input.input_source_config), input.input_source_config, alloc, &body_buf);
    has_prev = true;
    if (input.output_source_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"outputSourceConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"workflowName\":");
    try aws.json.writeValue(@TypeOf(input.workflow_name), input.workflow_name, alloc, &body_buf);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateIdMappingWorkflowOutput {
    var result: CreateIdMappingWorkflowOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateIdMappingWorkflowOutput, body, alloc);
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
