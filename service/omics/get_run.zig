const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RunExport = @import("run_export.zig").RunExport;
const Accelerators = @import("accelerators.zig").Accelerators;
const CacheBehavior = @import("cache_behavior.zig").CacheBehavior;
const RunLogLevel = @import("run_log_level.zig").RunLogLevel;
const RunLogLocation = @import("run_log_location.zig").RunLogLocation;
const RunRetentionMode = @import("run_retention_mode.zig").RunRetentionMode;
const RunStatus = @import("run_status.zig").RunStatus;
const StorageType = @import("storage_type.zig").StorageType;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

pub const GetRunInput = struct {
    /// The run's export format.
    @"export": ?[]const RunExport = null,

    /// The run's ID.
    id: []const u8,

    pub const json_field_names = .{
        .@"export" = "export",
        .id = "id",
    };
};

pub const GetRunOutput = struct {
    /// The computational accelerator used to run the workflow.
    accelerators: ?Accelerators = null,

    /// The run's ARN.
    arn: ?[]const u8 = null,

    /// The run cache behavior for the run.
    cache_behavior: ?CacheBehavior = null,

    /// The run cache associated with the run.
    cache_id: ?[]const u8 = null,

    /// When the run was created.
    creation_time: ?i64 = null,

    /// The run's definition.
    definition: ?[]const u8 = null,

    /// The run's digest.
    digest: ?[]const u8 = null,

    /// The actual Nextflow engine version that Amazon Web Services HealthOmics used
    /// for the run. The other workflow definition languages don't provide a value
    /// for this field.
    engine_version: ?[]const u8 = null,

    /// The reason a run has failed.
    failure_reason: ?[]const u8 = null,

    /// The run's ID.
    id: ?[]const u8 = null,

    /// The run's log level.
    log_level: ?RunLogLevel = null,

    /// The location of the run log.
    log_location: ?RunLogLocation = null,

    /// The run's name.
    name: ?[]const u8 = null,

    /// The run's output URI.
    output_uri: ?[]const u8 = null,

    /// The run's parameters.
    parameters: ?[]const u8 = null,

    /// The run's priority.
    priority: ?i32 = null,

    /// The run's resource digests.
    resource_digests: ?[]const aws.map.StringMapEntry = null,

    /// The run's retention mode.
    retention_mode: ?RunRetentionMode = null,

    /// The run's service role ARN.
    role_arn: ?[]const u8 = null,

    /// The run's group ID.
    run_group_id: ?[]const u8 = null,

    /// The run's ID.
    run_id: ?[]const u8 = null,

    /// The destination for workflow outputs.
    run_output_uri: ?[]const u8 = null,

    /// Who started the run.
    started_by: ?[]const u8 = null,

    /// When the run started.
    start_time: ?i64 = null,

    /// The run's status.
    status: ?RunStatus = null,

    /// The run's status message.
    status_message: ?[]const u8 = null,

    /// The run's stop time.
    stop_time: ?i64 = null,

    /// The run's storage capacity in gibibytes. For dynamic storage, after the run
    /// has completed, this value is the maximum amount of storage used during the
    /// run.
    storage_capacity: ?i32 = null,

    /// The run's storage type.
    storage_type: ?StorageType = null,

    /// The run's tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The universally unique identifier for a run.
    uuid: ?[]const u8 = null,

    /// The run's workflow ID.
    workflow_id: ?[]const u8 = null,

    /// The ID of the workflow owner.
    workflow_owner_id: ?[]const u8 = null,

    /// The run's workflow type.
    workflow_type: ?WorkflowType = null,

    /// The universally unique identifier (UUID) value for the workflow.
    workflow_uuid: ?[]const u8 = null,

    /// The workflow version name.
    workflow_version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .accelerators = "accelerators",
        .arn = "arn",
        .cache_behavior = "cacheBehavior",
        .cache_id = "cacheId",
        .creation_time = "creationTime",
        .definition = "definition",
        .digest = "digest",
        .engine_version = "engineVersion",
        .failure_reason = "failureReason",
        .id = "id",
        .log_level = "logLevel",
        .log_location = "logLocation",
        .name = "name",
        .output_uri = "outputUri",
        .parameters = "parameters",
        .priority = "priority",
        .resource_digests = "resourceDigests",
        .retention_mode = "retentionMode",
        .role_arn = "roleArn",
        .run_group_id = "runGroupId",
        .run_id = "runId",
        .run_output_uri = "runOutputUri",
        .started_by = "startedBy",
        .start_time = "startTime",
        .status = "status",
        .status_message = "statusMessage",
        .stop_time = "stopTime",
        .storage_capacity = "storageCapacity",
        .storage_type = "storageType",
        .tags = "tags",
        .uuid = "uuid",
        .workflow_id = "workflowId",
        .workflow_owner_id = "workflowOwnerId",
        .workflow_type = "workflowType",
        .workflow_uuid = "workflowUuid",
        .workflow_version_name = "workflowVersionName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRunInput, options: Options) !GetRunOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: GetRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/run/");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetRunOutput {
    var result: GetRunOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRunOutput, body, alloc);
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
