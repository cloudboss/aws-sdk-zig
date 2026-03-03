const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SessionCommand = @import("session_command.zig").SessionCommand;
const ConnectionsList = @import("connections_list.zig").ConnectionsList;
const WorkerType = @import("worker_type.zig").WorkerType;
const Session = @import("session.zig").Session;

pub const CreateSessionInput = struct {
    /// The `SessionCommand` that runs the job.
    command: SessionCommand,

    /// The number of connections to use for the session.
    connections: ?ConnectionsList = null,

    /// A map array of key-value pairs. Max is 75 pairs.
    default_arguments: ?[]const aws.map.StringMapEntry = null,

    /// The description of the session.
    description: ?[]const u8 = null,

    /// The Glue version determines the versions of Apache Spark and Python that
    /// Glue supports.
    /// The GlueVersion must be greater than 2.0.
    glue_version: ?[]const u8 = null,

    /// The ID of the session request.
    id: []const u8,

    /// The number of minutes when idle before session times out. Default for
    /// Spark ETL jobs is value of Timeout. Consult the documentation
    /// for other job types.
    idle_timeout: ?i32 = null,

    /// The number of Glue data processing units (DPUs) that can be allocated when
    /// the job runs.
    /// A DPU is a relative measure of processing power that consists of 4 vCPUs of
    /// compute capacity and 16 GB memory.
    max_capacity: ?f64 = null,

    /// The number of workers of a defined `WorkerType` to use for the session.
    number_of_workers: ?i32 = null,

    /// The origin of the request.
    request_origin: ?[]const u8 = null,

    /// The IAM Role ARN
    role: []const u8,

    /// The name of the SecurityConfiguration structure to be used with the session
    security_configuration: ?[]const u8 = null,

    /// The map of key value pairs (tags) belonging to the session.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The number of minutes before session times out. Default for Spark ETL
    /// jobs is 48 hours (2880 minutes).
    /// Consult the documentation for other job types.
    timeout: ?i32 = null,

    /// The type of predefined worker that is allocated when a job runs. Accepts a
    /// value of
    /// G.1X, G.2X, G.4X, or G.8X for Spark jobs. Accepts the value Z.2X for Ray
    /// notebooks.
    ///
    /// * For the `G.1X` worker type, each worker maps to 1 DPU (4 vCPUs, 16 GB of
    ///   memory) with 94GB disk, and provides 1 executor per worker. We recommend
    ///   this worker type for workloads such as data transforms, joins, and
    ///   queries, to offers a scalable and cost effective way to run most jobs.
    ///
    /// * For the `G.2X` worker type, each worker maps to 2 DPU (8 vCPUs, 32 GB of
    ///   memory) with 138GB disk, and provides 1 executor per worker. We recommend
    ///   this worker type for workloads such as data transforms, joins, and
    ///   queries, to offers a scalable and cost effective way to run most jobs.
    ///
    /// * For the `G.4X` worker type, each worker maps to 4 DPU (16 vCPUs, 64 GB of
    ///   memory) with 256GB disk, and provides 1 executor per worker. We recommend
    ///   this worker type for jobs whose workloads contain your most demanding
    ///   transforms, aggregations, joins, and queries. This worker type is
    ///   available only for Glue version 3.0 or later Spark ETL jobs in the
    ///   following Amazon Web Services Regions: US East (Ohio), US East (N.
    ///   Virginia), US West (Oregon), Asia Pacific (Singapore), Asia Pacific
    ///   (Sydney), Asia Pacific (Tokyo), Canada (Central), Europe (Frankfurt),
    ///   Europe (Ireland), and Europe (Stockholm).
    ///
    /// * For the `G.8X` worker type, each worker maps to 8 DPU (32 vCPUs, 128 GB of
    ///   memory) with 512GB disk, and provides 1 executor per worker. We recommend
    ///   this worker type for jobs whose workloads contain your most demanding
    ///   transforms, aggregations, joins, and queries. This worker type is
    ///   available only for Glue version 3.0 or later Spark ETL jobs, in the same
    ///   Amazon Web Services Regions as supported for the `G.4X` worker type.
    ///
    /// * For the `Z.2X` worker type, each worker maps to 2 M-DPU (8vCPUs, 64 GB of
    ///   memory) with 128 GB disk, and provides up to 8 Ray workers based on the
    ///   autoscaler.
    worker_type: ?WorkerType = null,

    pub const json_field_names = .{
        .command = "Command",
        .connections = "Connections",
        .default_arguments = "DefaultArguments",
        .description = "Description",
        .glue_version = "GlueVersion",
        .id = "Id",
        .idle_timeout = "IdleTimeout",
        .max_capacity = "MaxCapacity",
        .number_of_workers = "NumberOfWorkers",
        .request_origin = "RequestOrigin",
        .role = "Role",
        .security_configuration = "SecurityConfiguration",
        .tags = "Tags",
        .timeout = "Timeout",
        .worker_type = "WorkerType",
    };
};

pub const CreateSessionOutput = struct {
    /// Returns the session object in the response.
    session: ?Session = null,

    pub const json_field_names = .{
        .session = "Session",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSessionInput, options: Options) !CreateSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "glue");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSessionOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ColumnStatisticsTaskNotRunningException")) {
        return .{ .arena = arena, .kind = .{ .column_statistics_task_not_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ColumnStatisticsTaskRunningException")) {
        return .{ .arena = arena, .kind = .{ .column_statistics_task_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ColumnStatisticsTaskStoppingException")) {
        return .{ .arena = arena, .kind = .{ .column_statistics_task_stopping_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentRunsExceededException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_runs_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConditionCheckFailureException")) {
        return .{ .arena = arena, .kind = .{ .condition_check_failure_exception = .{
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
    if (std.mem.eql(u8, error_code, "CrawlerNotRunningException")) {
        return .{ .arena = arena, .kind = .{ .crawler_not_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CrawlerRunningException")) {
        return .{ .arena = arena, .kind = .{ .crawler_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CrawlerStoppingException")) {
        return .{ .arena = arena, .kind = .{ .crawler_stopping_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntityNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .entity_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FederatedResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .federated_resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FederationSourceException")) {
        return .{ .arena = arena, .kind = .{ .federation_source_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FederationSourceRetryableException")) {
        return .{ .arena = arena, .kind = .{ .federation_source_retryable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GlueEncryptionException")) {
        return .{ .arena = arena, .kind = .{ .glue_encryption_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalBlueprintStateException")) {
        return .{ .arena = arena, .kind = .{ .illegal_blueprint_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalSessionStateException")) {
        return .{ .arena = arena, .kind = .{ .illegal_session_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalWorkflowStateException")) {
        return .{ .arena = arena, .kind = .{ .illegal_workflow_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationConflictOperationFault")) {
        return .{ .arena = arena, .kind = .{ .integration_conflict_operation_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .integration_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IntegrationQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .integration_quota_exceeded_fault = .{
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
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidIntegrationStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_integration_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSKeyNotAccessibleFault")) {
        return .{ .arena = arena, .kind = .{ .kms_key_not_accessible_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaterializedViewRefreshTaskNotRunningException")) {
        return .{ .arena = arena, .kind = .{ .materialized_view_refresh_task_not_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaterializedViewRefreshTaskRunningException")) {
        return .{ .arena = arena, .kind = .{ .materialized_view_refresh_task_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaterializedViewRefreshTaskStoppingException")) {
        return .{ .arena = arena, .kind = .{ .materialized_view_refresh_task_stopping_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MLTransformNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .ml_transform_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoScheduleException")) {
        return .{ .arena = arena, .kind = .{ .no_schedule_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .operation_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PermissionTypeMismatchException")) {
        return .{ .arena = arena, .kind = .{ .permission_type_mismatch_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNumberLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_number_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SchedulerNotRunningException")) {
        return .{ .arena = arena, .kind = .{ .scheduler_not_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SchedulerRunningException")) {
        return .{ .arena = arena, .kind = .{ .scheduler_running_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SchedulerTransitioningException")) {
        return .{ .arena = arena, .kind = .{ .scheduler_transitioning_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .target_resource_not_found = .{
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
    if (std.mem.eql(u8, error_code, "VersionMismatchException")) {
        return .{ .arena = arena, .kind = .{ .version_mismatch_exception = .{
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
