const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDevEndpointInput, options: CallOptions) !CreateDevEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDevEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        const parsed_error: ?errors.AlreadyExistsException = aws.json.parseJsonObject(errors.AlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ColumnStatisticsTaskNotRunningException")) {
        const parsed_error: ?errors.ColumnStatisticsTaskNotRunningException = aws.json.parseJsonObject(errors.ColumnStatisticsTaskNotRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .column_statistics_task_not_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ColumnStatisticsTaskRunningException")) {
        const parsed_error: ?errors.ColumnStatisticsTaskRunningException = aws.json.parseJsonObject(errors.ColumnStatisticsTaskRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .column_statistics_task_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ColumnStatisticsTaskStoppingException")) {
        const parsed_error: ?errors.ColumnStatisticsTaskStoppingException = aws.json.parseJsonObject(errors.ColumnStatisticsTaskStoppingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .column_statistics_task_stopping_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        const parsed_error: ?errors.ConcurrentModificationException = aws.json.parseJsonObject(errors.ConcurrentModificationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConcurrentRunsExceededException")) {
        const parsed_error: ?errors.ConcurrentRunsExceededException = aws.json.parseJsonObject(errors.ConcurrentRunsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_runs_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConditionCheckFailureException")) {
        const parsed_error: ?errors.ConditionCheckFailureException = aws.json.parseJsonObject(errors.ConditionCheckFailureException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .condition_check_failure_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CrawlerNotRunningException")) {
        const parsed_error: ?errors.CrawlerNotRunningException = aws.json.parseJsonObject(errors.CrawlerNotRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .crawler_not_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CrawlerRunningException")) {
        const parsed_error: ?errors.CrawlerRunningException = aws.json.parseJsonObject(errors.CrawlerRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .crawler_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CrawlerStoppingException")) {
        const parsed_error: ?errors.CrawlerStoppingException = aws.json.parseJsonObject(errors.CrawlerStoppingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .crawler_stopping_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EntityNotFoundException")) {
        const parsed_error: ?errors.EntityNotFoundException = aws.json.parseJsonObject(errors.EntityNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .entity_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FederatedResourceAlreadyExistsException")) {
        const parsed_error: ?errors.FederatedResourceAlreadyExistsException = aws.json.parseJsonObject(errors.FederatedResourceAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .federated_resource_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FederationSourceException")) {
        const parsed_error: ?errors.FederationSourceException = aws.json.parseJsonObject(errors.FederationSourceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .federation_source_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FederationSourceRetryableException")) {
        const parsed_error: ?errors.FederationSourceRetryableException = aws.json.parseJsonObject(errors.FederationSourceRetryableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .federation_source_retryable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "GlueEncryptionException")) {
        const parsed_error: ?errors.GlueEncryptionException = aws.json.parseJsonObject(errors.GlueEncryptionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .glue_encryption_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        const parsed_error: ?errors.IdempotentParameterMismatchException = aws.json.parseJsonObject(errors.IdempotentParameterMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IllegalBlueprintStateException")) {
        const parsed_error: ?errors.IllegalBlueprintStateException = aws.json.parseJsonObject(errors.IllegalBlueprintStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .illegal_blueprint_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IllegalSessionStateException")) {
        const parsed_error: ?errors.IllegalSessionStateException = aws.json.parseJsonObject(errors.IllegalSessionStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .illegal_session_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IllegalWorkflowStateException")) {
        const parsed_error: ?errors.IllegalWorkflowStateException = aws.json.parseJsonObject(errors.IllegalWorkflowStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .illegal_workflow_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IntegrationConflictOperationFault")) {
        const parsed_error: ?errors.IntegrationConflictOperationFault = aws.json.parseJsonObject(errors.IntegrationConflictOperationFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .integration_conflict_operation_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IntegrationNotFoundFault")) {
        const parsed_error: ?errors.IntegrationNotFoundFault = aws.json.parseJsonObject(errors.IntegrationNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .integration_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IntegrationQuotaExceededFault")) {
        const parsed_error: ?errors.IntegrationQuotaExceededFault = aws.json.parseJsonObject(errors.IntegrationQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .integration_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?errors.InternalServerException = aws.json.parseJsonObject(errors.InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        const parsed_error: ?errors.InternalServiceException = aws.json.parseJsonObject(errors.InternalServiceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_service_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        const parsed_error: ?errors.InvalidInputException = aws.json.parseJsonObject(errors.InvalidInputException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_input_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidIntegrationStateFault")) {
        const parsed_error: ?errors.InvalidIntegrationStateFault = aws.json.parseJsonObject(errors.InvalidIntegrationStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_integration_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        const parsed_error: ?errors.InvalidStateException = aws.json.parseJsonObject(errors.InvalidStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSKeyNotAccessibleFault")) {
        const parsed_error: ?errors.KMSKeyNotAccessibleFault = aws.json.parseJsonObject(errors.KMSKeyNotAccessibleFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_key_not_accessible_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaterializedViewRefreshTaskNotRunningException")) {
        const parsed_error: ?errors.MaterializedViewRefreshTaskNotRunningException = aws.json.parseJsonObject(errors.MaterializedViewRefreshTaskNotRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .materialized_view_refresh_task_not_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaterializedViewRefreshTaskRunningException")) {
        const parsed_error: ?errors.MaterializedViewRefreshTaskRunningException = aws.json.parseJsonObject(errors.MaterializedViewRefreshTaskRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .materialized_view_refresh_task_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaterializedViewRefreshTaskStoppingException")) {
        const parsed_error: ?errors.MaterializedViewRefreshTaskStoppingException = aws.json.parseJsonObject(errors.MaterializedViewRefreshTaskStoppingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .materialized_view_refresh_task_stopping_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MLTransformNotReadyException")) {
        const parsed_error: ?errors.MLTransformNotReadyException = aws.json.parseJsonObject(errors.MLTransformNotReadyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ml_transform_not_ready_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoScheduleException")) {
        const parsed_error: ?errors.NoScheduleException = aws.json.parseJsonObject(errors.NoScheduleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_schedule_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationNotSupportedException")) {
        const parsed_error: ?errors.OperationNotSupportedException = aws.json.parseJsonObject(errors.OperationNotSupportedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_not_supported_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationTimeoutException")) {
        const parsed_error: ?errors.OperationTimeoutException = aws.json.parseJsonObject(errors.OperationTimeoutException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_timeout_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PermissionTypeMismatchException")) {
        const parsed_error: ?errors.PermissionTypeMismatchException = aws.json.parseJsonObject(errors.PermissionTypeMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .permission_type_mismatch_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        const parsed_error: ?errors.ResourceNotReadyException = aws.json.parseJsonObject(errors.ResourceNotReadyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_ready_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNumberLimitExceededException")) {
        const parsed_error: ?errors.ResourceNumberLimitExceededException = aws.json.parseJsonObject(errors.ResourceNumberLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_number_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SchedulerNotRunningException")) {
        const parsed_error: ?errors.SchedulerNotRunningException = aws.json.parseJsonObject(errors.SchedulerNotRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .scheduler_not_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SchedulerRunningException")) {
        const parsed_error: ?errors.SchedulerRunningException = aws.json.parseJsonObject(errors.SchedulerRunningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .scheduler_running_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SchedulerTransitioningException")) {
        const parsed_error: ?errors.SchedulerTransitioningException = aws.json.parseJsonObject(errors.SchedulerTransitioningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .scheduler_transitioning_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TargetResourceNotFound")) {
        const parsed_error: ?errors.TargetResourceNotFound = aws.json.parseJsonObject(errors.TargetResourceNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .target_resource_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "VersionMismatchException")) {
        const parsed_error: ?errors.VersionMismatchException = aws.json.parseJsonObject(errors.VersionMismatchException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .version_mismatch_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
