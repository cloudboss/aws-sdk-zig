const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const WorkerType = @import("worker_type.zig").WorkerType;

pub const CreateDevEndpointInput = struct {
    /// A map of arguments used to configure the `DevEndpoint`.
    arguments: ?[]const aws.map.StringMapEntry = null,

    /// The name to be assigned to the new `DevEndpoint`.
    endpoint_name: []const u8,

    /// The path to one or more Java `.jar` files in an S3 bucket that should be
    /// loaded
    /// in your `DevEndpoint`.
    extra_jars_s3_path: ?[]const u8 = null,

    /// The paths to one or more Python libraries in an Amazon S3 bucket that should
    /// be loaded in
    /// your `DevEndpoint`. Multiple values must be complete paths separated by a
    /// comma.
    ///
    /// You can only use pure Python libraries with a `DevEndpoint`. Libraries that
    /// rely on
    /// C extensions, such as the [pandas](http://pandas.pydata.org/) Python data
    /// analysis library, are not yet supported.
    extra_python_libs_s3_path: ?[]const u8 = null,

    /// Glue version determines the versions of Apache Spark and Python that Glue
    /// supports. The Python version indicates the version supported for running
    /// your ETL scripts on development endpoints.
    ///
    /// For more information about the available Glue versions and corresponding
    /// Spark and Python versions, see [Glue
    /// version](https://docs.aws.amazon.com/glue/latest/dg/add-job.html) in the
    /// developer guide.
    ///
    /// Development endpoints that are created without specifying a Glue version
    /// default to Glue 0.9.
    ///
    /// You can specify a version of Python support for development endpoints by
    /// using the `Arguments` parameter in the `CreateDevEndpoint` or
    /// `UpdateDevEndpoint` APIs. If no arguments are provided, the version defaults
    /// to Python 2.
    glue_version: ?[]const u8 = null,

    /// The number of Glue Data Processing Units (DPUs) to allocate to this
    /// `DevEndpoint`.
    number_of_nodes: ?i32 = null,

    /// The number of workers of a defined `workerType` that are allocated to the
    /// development endpoint.
    ///
    /// The maximum number of workers you can define are 299 for `G.1X`, and 149 for
    /// `G.2X`.
    number_of_workers: ?i32 = null,

    /// The public key to be used by this `DevEndpoint` for authentication. This
    /// attribute is provided for backward compatibility because the recommended
    /// attribute to use is
    /// public keys.
    public_key: ?[]const u8 = null,

    /// A list of public keys to be used by the development endpoints for
    /// authentication. The use
    /// of this attribute is preferred over a single public key because the public
    /// keys allow you to
    /// have a different private key per client.
    ///
    /// If you previously created an endpoint with a public key, you must remove
    /// that key to be able
    /// to set a list of public keys. Call the `UpdateDevEndpoint` API with the
    /// public
    /// key content in the `deletePublicKeys` attribute, and the list of new keys in
    /// the
    /// `addPublicKeys` attribute.
    public_keys: ?[]const []const u8 = null,

    /// The IAM role for the `DevEndpoint`.
    role_arn: []const u8,

    /// The name of the `SecurityConfiguration` structure to be used with this
    /// `DevEndpoint`.
    security_configuration: ?[]const u8 = null,

    /// Security group IDs for the security groups to be used by the new
    /// `DevEndpoint`.
    security_group_ids: ?[]const []const u8 = null,

    /// The subnet ID for the new `DevEndpoint` to use.
    subnet_id: ?[]const u8 = null,

    /// The tags to use with this DevEndpoint. You may use tags to limit access to
    /// the DevEndpoint. For more information about tags in Glue, see [Amazon Web
    /// Services Tags in
    /// Glue](https://docs.aws.amazon.com/glue/latest/dg/monitor-tags.html) in the
    /// developer guide.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of predefined worker that is allocated to the development endpoint.
    /// Accepts a value of Standard, G.1X, or G.2X.
    ///
    /// * For the `Standard` worker type, each worker provides 4 vCPU, 16 GB of
    ///   memory and a 50GB disk, and 2 executors per worker.
    ///
    /// * For the `G.1X` worker type, each worker maps to 1 DPU (4 vCPU, 16 GB of
    ///   memory, 64 GB disk), and provides 1 executor per worker. We recommend this
    ///   worker type for memory-intensive jobs.
    ///
    /// * For the `G.2X` worker type, each worker maps to 2 DPU (8 vCPU, 32 GB of
    ///   memory, 128 GB disk), and provides 1 executor per worker. We recommend
    ///   this worker type for memory-intensive jobs.
    ///
    /// Known issue: when a development endpoint is created with the `G.2X`
    /// `WorkerType` configuration, the Spark drivers for the development endpoint
    /// will run on 4 vCPU, 16 GB of memory, and a 64 GB disk.
    worker_type: ?WorkerType = null,

    pub const json_field_names = .{
        .arguments = "Arguments",
        .endpoint_name = "EndpointName",
        .extra_jars_s3_path = "ExtraJarsS3Path",
        .extra_python_libs_s3_path = "ExtraPythonLibsS3Path",
        .glue_version = "GlueVersion",
        .number_of_nodes = "NumberOfNodes",
        .number_of_workers = "NumberOfWorkers",
        .public_key = "PublicKey",
        .public_keys = "PublicKeys",
        .role_arn = "RoleArn",
        .security_configuration = "SecurityConfiguration",
        .security_group_ids = "SecurityGroupIds",
        .subnet_id = "SubnetId",
        .tags = "Tags",
        .worker_type = "WorkerType",
    };
};

pub const CreateDevEndpointOutput = struct {
    /// The map of arguments used to configure this `DevEndpoint`.
    ///
    /// Valid arguments are:
    ///
    /// * `"--enable-glue-datacatalog": ""`
    ///
    /// You can specify a version of Python support for development endpoints by
    /// using the `Arguments` parameter in the `CreateDevEndpoint` or
    /// `UpdateDevEndpoint` APIs. If no arguments are provided, the version defaults
    /// to Python 2.
    arguments: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Web Services Availability Zone where this `DevEndpoint` is
    /// located.
    availability_zone: ?[]const u8 = null,

    /// The point in time at which this `DevEndpoint` was created.
    created_timestamp: ?i64 = null,

    /// The name assigned to the new `DevEndpoint`.
    endpoint_name: ?[]const u8 = null,

    /// Path to one or more Java `.jar` files in an S3 bucket that will be loaded in
    /// your `DevEndpoint`.
    extra_jars_s3_path: ?[]const u8 = null,

    /// The paths to one or more Python libraries in an S3 bucket that will be
    /// loaded in your
    /// `DevEndpoint`.
    extra_python_libs_s3_path: ?[]const u8 = null,

    /// The reason for a current failure in this `DevEndpoint`.
    failure_reason: ?[]const u8 = null,

    /// Glue version determines the versions of Apache Spark and Python that Glue
    /// supports. The Python version indicates the version supported for running
    /// your ETL scripts on development endpoints.
    ///
    /// For more information about the available Glue versions and corresponding
    /// Spark and Python versions, see [Glue
    /// version](https://docs.aws.amazon.com/glue/latest/dg/add-job.html) in the
    /// developer guide.
    glue_version: ?[]const u8 = null,

    /// The number of Glue Data Processing Units (DPUs) allocated to this
    /// DevEndpoint.
    number_of_nodes: ?i32 = null,

    /// The number of workers of a defined `workerType` that are allocated to the
    /// development endpoint.
    number_of_workers: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the role assigned to the new
    /// `DevEndpoint`.
    role_arn: ?[]const u8 = null,

    /// The name of the `SecurityConfiguration` structure being used with this
    /// `DevEndpoint`.
    security_configuration: ?[]const u8 = null,

    /// The security groups assigned to the new `DevEndpoint`.
    security_group_ids: ?[]const []const u8 = null,

    /// The current status of the new `DevEndpoint`.
    status: ?[]const u8 = null,

    /// The subnet ID assigned to the new `DevEndpoint`.
    subnet_id: ?[]const u8 = null,

    /// The ID of the virtual private cloud (VPC) used by this `DevEndpoint`.
    vpc_id: ?[]const u8 = null,

    /// The type of predefined worker that is allocated to the development endpoint.
    /// May be a value of Standard, G.1X, or G.2X.
    worker_type: ?WorkerType = null,

    /// The address of the YARN endpoint used by this `DevEndpoint`.
    yarn_endpoint_address: ?[]const u8 = null,

    /// The Apache Zeppelin port for the remote Apache Spark interpreter.
    zeppelin_remote_spark_interpreter_port: ?i32 = null,

    pub const json_field_names = .{
        .arguments = "Arguments",
        .availability_zone = "AvailabilityZone",
        .created_timestamp = "CreatedTimestamp",
        .endpoint_name = "EndpointName",
        .extra_jars_s3_path = "ExtraJarsS3Path",
        .extra_python_libs_s3_path = "ExtraPythonLibsS3Path",
        .failure_reason = "FailureReason",
        .glue_version = "GlueVersion",
        .number_of_nodes = "NumberOfNodes",
        .number_of_workers = "NumberOfWorkers",
        .role_arn = "RoleArn",
        .security_configuration = "SecurityConfiguration",
        .security_group_ids = "SecurityGroupIds",
        .status = "Status",
        .subnet_id = "SubnetId",
        .vpc_id = "VpcId",
        .worker_type = "WorkerType",
        .yarn_endpoint_address = "YarnEndpointAddress",
        .zeppelin_remote_spark_interpreter_port = "ZeppelinRemoteSparkInterpreterPort",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDevEndpointInput, options: Options) !CreateDevEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDevEndpointInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateDevEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDevEndpointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDevEndpointOutput, body, allocator);
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
