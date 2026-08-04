const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const ExecutionClass = @import("execution_class.zig").ExecutionClass;
const NotificationProperty = @import("notification_property.zig").NotificationProperty;
const WorkerType = @import("worker_type.zig").WorkerType;

pub const StartJobRunInput = struct {
    /// This field is deprecated. Use `MaxCapacity` instead.
    ///
    /// The number of Glue data processing units (DPUs) to allocate to this JobRun.
    /// You can allocate a minimum of 2 DPUs; the default is 10. A DPU is a relative
    /// measure
    /// of processing power that consists of 4 vCPUs of compute capacity and 16 GB
    /// of memory.
    /// For more information, see the [Glue
    /// pricing page](https://aws.amazon.com/glue/pricing/).
    allocated_capacity: ?i32 = null,

    /// The job arguments associated with this run. For this job run, they replace
    /// the default
    /// arguments set in the job definition itself.
    ///
    /// You can specify arguments here that your own job-execution script
    /// consumes, as well as arguments that Glue itself consumes.
    ///
    /// Job arguments may be logged. Do not pass plaintext secrets as arguments.
    /// Retrieve secrets
    /// from a Glue Connection, Secrets Manager or other secret management
    /// mechanism if you intend to keep them within the Job.
    ///
    /// For information about how to specify and consume your own Job arguments, see
    /// the [Calling Glue APIs in
    /// Python](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-python-calling.html) topic in the developer guide.
    ///
    /// For information about the arguments you can provide to this field when
    /// configuring Spark jobs,
    /// see the [Special Parameters Used by
    /// Glue](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-etl-glue-arguments.html) topic in the developer guide.
    ///
    /// For information about the arguments you can provide to this field when
    /// configuring Ray
    /// jobs, see [Using
    /// job parameters in Ray
    /// jobs](https://docs.aws.amazon.com/glue/latest/dg/author-job-ray-job-parameters.html) in the developer guide.
    arguments: ?[]const aws.map.StringMapEntry = null,

    /// Indicates whether the job is run with a standard or flexible execution
    /// class. The standard execution-class is ideal for time-sensitive workloads
    /// that require fast job startup and dedicated resources.
    ///
    /// The flexible execution class is appropriate for time-insensitive jobs whose
    /// start and completion times may vary.
    ///
    /// Only jobs with Glue version 3.0 and above and command type `glueetl` will be
    /// allowed to set `ExecutionClass` to `FLEX`. The flexible execution class is
    /// available for Spark jobs.
    execution_class: ?ExecutionClass = null,

    /// This inline session policy to the StartJobRun API allows you to dynamically
    /// restrict the permissions of the specified
    /// execution role for the scope of the job, without requiring the creation of
    /// additional IAM roles.
    execution_role_session_policy: ?[]const u8 = null,

    /// The name of the job definition to use.
    job_name: []const u8,

    /// The ID of a previous `JobRun` to retry.
    job_run_id: ?[]const u8 = null,

    /// Specifies whether job run queuing is enabled for the job run.
    ///
    /// A value of true means job run queuing is enabled for the job run. If false
    /// or not populated, the job run will not be considered for queueing.
    job_run_queuing_enabled: ?bool = null,

    /// For Glue version 1.0 or earlier jobs, using the standard worker type, the
    /// number of
    /// Glue data processing units (DPUs) that can be allocated when this job runs.
    /// A DPU is
    /// a relative measure of processing power that consists of 4 vCPUs of compute
    /// capacity and 16 GB
    /// of memory. For more information, see the [
    /// Glue pricing page](https://aws.amazon.com/glue/pricing/).
    ///
    /// For Glue version 2.0+ jobs, you cannot specify a `Maximum capacity`.
    /// Instead, you should specify a `Worker type` and the `Number of workers`.
    ///
    /// Do not set `MaxCapacity` if using `WorkerType` and `NumberOfWorkers`.
    ///
    /// The value that can be allocated for `MaxCapacity` depends on whether you are
    /// running a Python shell job, an Apache Spark ETL job, or an Apache Spark
    /// streaming ETL
    /// job:
    ///
    /// * When you specify a Python shell job (`JobCommand.Name`="pythonshell"), you
    ///   can
    /// allocate either 0.0625 or 1 DPU. The default is 0.0625 DPU.
    ///
    /// * When you specify an Apache Spark ETL job (`JobCommand.Name`="glueetl") or
    ///   Apache
    /// Spark streaming ETL job (`JobCommand.Name`="gluestreaming"), you can
    /// allocate from 2 to 100 DPUs.
    /// The default is 10 DPUs. This job type cannot have a fractional DPU
    /// allocation.
    max_capacity: ?f64 = null,

    /// Specifies configuration properties of a job run notification.
    notification_property: ?NotificationProperty = null,

    /// The number of workers of a defined `workerType` that are allocated when a
    /// job runs.
    number_of_workers: ?i32 = null,

    /// The name of the `SecurityConfiguration` structure to be used with this job
    /// run.
    security_configuration: ?[]const u8 = null,

    /// The `JobRun` timeout in minutes. This is the maximum time that a job run can
    /// consume resources before it is terminated and enters `TIMEOUT` status. This
    /// value overrides the timeout value set in the parent job.
    ///
    /// Jobs must have timeout values less than 7 days or 10080 minutes. Otherwise,
    /// the jobs will throw an exception.
    ///
    /// When the value is left blank, the timeout is defaulted to 2880 minutes.
    ///
    /// Any existing Glue jobs that had a timeout value greater than 7 days will be
    /// defaulted to 7 days. For instance if you have specified a timeout of 20 days
    /// for a batch job, it will be stopped on the 7th day.
    ///
    /// For streaming jobs, if you have set up a maintenance window, it will be
    /// restarted during the maintenance window after 7 days.
    timeout: ?i32 = null,

    /// The type of predefined worker that is allocated when a job runs. Accepts a
    /// value of
    /// G.1X, G.2X, G.4X, G.8X or G.025X for Spark jobs. Accepts the value Z.2X for
    /// Ray jobs.
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
    /// * For the `G.025X` worker type, each worker maps to 0.25 DPU (2 vCPUs, 4 GB
    ///   of memory) with 84GB disk, and provides 1 executor per worker. We
    ///   recommend this worker type for low volume streaming jobs. This worker type
    ///   is only available for Glue version 3.0 or later streaming jobs.
    ///
    /// * For the `Z.2X` worker type, each worker maps to 2 M-DPU (8vCPUs, 64 GB of
    ///   memory) with 128 GB disk, and provides up to 8 Ray workers based on the
    ///   autoscaler.
    worker_type: ?WorkerType = null,

    pub const json_field_names = .{
        .allocated_capacity = "AllocatedCapacity",
        .arguments = "Arguments",
        .execution_class = "ExecutionClass",
        .execution_role_session_policy = "ExecutionRoleSessionPolicy",
        .job_name = "JobName",
        .job_run_id = "JobRunId",
        .job_run_queuing_enabled = "JobRunQueuingEnabled",
        .max_capacity = "MaxCapacity",
        .notification_property = "NotificationProperty",
        .number_of_workers = "NumberOfWorkers",
        .security_configuration = "SecurityConfiguration",
        .timeout = "Timeout",
        .worker_type = "WorkerType",
    };
};

pub const StartJobRunOutput = struct {
    /// The ID assigned to this job run.
    job_run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_run_id = "JobRunId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartJobRunInput, options: CallOptions) !StartJobRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartJobRunInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.StartJobRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartJobRunOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartJobRunOutput, body, allocator);
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
