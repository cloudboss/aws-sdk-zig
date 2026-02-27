const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const WorkflowExport = @import("workflow_export.zig").WorkflowExport;
const WorkflowType = @import("workflow_type.zig").WorkflowType;
const Accelerators = @import("accelerators.zig").Accelerators;
const ContainerRegistryMap = @import("container_registry_map.zig").ContainerRegistryMap;
const DefinitionRepositoryDetails = @import("definition_repository_details.zig").DefinitionRepositoryDetails;
const WorkflowEngine = @import("workflow_engine.zig").WorkflowEngine;
const WorkflowParameter = @import("workflow_parameter.zig").WorkflowParameter;
const WorkflowStatus = @import("workflow_status.zig").WorkflowStatus;
const StorageType = @import("storage_type.zig").StorageType;

pub const GetWorkflowInput = struct {
    /// The export format for the workflow.
    @"export": ?[]const WorkflowExport = null,

    /// The workflow's ID.
    id: []const u8,

    /// The workflow's type.
    type: ?WorkflowType = null,

    /// The ID of the workflow owner.
    workflow_owner_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .@"export" = "export",
        .id = "id",
        .type = "type",
        .workflow_owner_id = "workflowOwnerId",
    };
};

pub const GetWorkflowOutput = struct {
    /// The computational accelerator specified to run the workflow.
    accelerators: ?Accelerators = null,

    /// The workflow's ARN.
    arn: ?[]const u8 = null,

    /// The registry map that this workflow is using.
    container_registry_map: ?ContainerRegistryMap = null,

    /// When the workflow was created.
    creation_time: ?i64 = null,

    /// The workflow's definition.
    definition: ?[]const u8 = null,

    /// Details about the source code repository that hosts the workflow definition
    /// files.
    definition_repository_details: ?DefinitionRepositoryDetails = null,

    /// The workflow's description.
    description: ?[]const u8 = null,

    /// The workflow's digest.
    digest: ?[]const u8 = null,

    /// The workflow's engine.
    engine: ?WorkflowEngine = null,

    /// The workflow's ID.
    id: ?[]const u8 = null,

    /// The path of the main definition file for the workflow.
    main: ?[]const u8 = null,

    /// Gets metadata for the workflow.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The workflow's name.
    name: ?[]const u8 = null,

    /// The workflow's parameter template.
    parameter_template: ?[]const aws.map.MapEntry(WorkflowParameter) = null,

    /// The README content for the workflow, providing documentation and usage
    /// information.
    readme: ?[]const u8 = null,

    /// The path to the workflow README markdown file within the repository. This
    /// file provides documentation and usage information for the workflow. If not
    /// specified, the `README.md` file from the root directory of the repository
    /// will be used.
    readme_path: ?[]const u8 = null,

    /// The workflow's status.
    status: ?WorkflowStatus = null,

    /// The workflow's status message.
    status_message: ?[]const u8 = null,

    /// The default static storage capacity (in gibibytes) for runs that use this
    /// workflow or workflow version.
    storage_capacity: ?i32 = null,

    /// The default storage type for runs using this workflow.
    storage_type: ?StorageType = null,

    /// The workflow's tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The workflow's type.
    type: ?WorkflowType = null,

    /// The universally unique identifier (UUID) value for this workflow.
    uuid: ?[]const u8 = null,

    pub const json_field_names = .{
        .accelerators = "accelerators",
        .arn = "arn",
        .container_registry_map = "containerRegistryMap",
        .creation_time = "creationTime",
        .definition = "definition",
        .definition_repository_details = "definitionRepositoryDetails",
        .description = "description",
        .digest = "digest",
        .engine = "engine",
        .id = "id",
        .main = "main",
        .metadata = "metadata",
        .name = "name",
        .parameter_template = "parameterTemplate",
        .readme = "readme",
        .readme_path = "readmePath",
        .status = "status",
        .status_message = "statusMessage",
        .storage_capacity = "storageCapacity",
        .storage_type = "storageType",
        .tags = "tags",
        .type = "type",
        .uuid = "uuid",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowInput, options: Options) !GetWorkflowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "omics");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/workflow/");
    try path_buf.appendSlice(alloc, input.id);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.@"export") |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "export=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.type) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "type=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (input.workflow_owner_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "workflowOwnerId=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetWorkflowOutput {
    var result: GetWorkflowOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetWorkflowOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "NotSupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .not_supported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RangeNotSatisfiableException")) {
        return .{ .arena = arena, .kind = .{ .range_not_satisfiable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .request_timeout_exception = .{
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
