const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AppSpecification = @import("app_specification.zig").AppSpecification;
const ExperimentConfig = @import("experiment_config.zig").ExperimentConfig;
const NetworkConfig = @import("network_config.zig").NetworkConfig;
const ProcessingInput = @import("processing_input.zig").ProcessingInput;
const ProcessingJobStatus = @import("processing_job_status.zig").ProcessingJobStatus;
const ProcessingOutputConfig = @import("processing_output_config.zig").ProcessingOutputConfig;
const ProcessingResources = @import("processing_resources.zig").ProcessingResources;
const ProcessingStoppingCondition = @import("processing_stopping_condition.zig").ProcessingStoppingCondition;

pub const DescribeProcessingJobInput = struct {
    /// The name of the processing job. The name must be unique within an Amazon Web
    /// Services Region in the Amazon Web Services account.
    processing_job_name: []const u8,

    pub const json_field_names = .{
        .processing_job_name = "ProcessingJobName",
    };
};

pub const DescribeProcessingJobOutput = struct {
    /// Configures the processing job to run a specified container image.
    app_specification: ?AppSpecification = null,

    /// The ARN of an AutoML job associated with this processing job.
    auto_ml_job_arn: ?[]const u8 = null,

    /// The time at which the processing job was created.
    creation_time: i64,

    /// The environment variables set in the Docker container.
    environment: ?[]const aws.map.StringMapEntry = null,

    /// An optional string, up to one KB in size, that contains metadata from the
    /// processing container when the processing job exits.
    exit_message: ?[]const u8 = null,

    /// The configuration information used to create an experiment.
    experiment_config: ?ExperimentConfig = null,

    /// A string, up to one KB in size, that contains the reason a processing job
    /// failed, if it failed.
    failure_reason: ?[]const u8 = null,

    /// The time at which the processing job was last modified.
    last_modified_time: ?i64 = null,

    /// The ARN of a monitoring schedule for an endpoint associated with this
    /// processing job.
    monitoring_schedule_arn: ?[]const u8 = null,

    /// Networking options for a processing job.
    network_config: ?NetworkConfig = null,

    /// The time at which the processing job completed.
    processing_end_time: ?i64 = null,

    /// The inputs for a processing job.
    processing_inputs: ?[]const ProcessingInput = null,

    /// The Amazon Resource Name (ARN) of the processing job.
    processing_job_arn: []const u8,

    /// The name of the processing job. The name must be unique within an Amazon Web
    /// Services Region in the Amazon Web Services account.
    processing_job_name: []const u8,

    /// Provides the status of a processing job.
    processing_job_status: ProcessingJobStatus,

    /// Output configuration for the processing job.
    processing_output_config: ?ProcessingOutputConfig = null,

    /// Identifies the resources, ML compute instances, and ML storage volumes to
    /// deploy for a processing job. In distributed training, you specify more than
    /// one instance.
    processing_resources: ?ProcessingResources = null,

    /// The time at which the processing job started.
    processing_start_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that Amazon SageMaker can
    /// assume to perform tasks on your behalf.
    role_arn: ?[]const u8 = null,

    /// The time limit for how long the processing job is allowed to run.
    stopping_condition: ?ProcessingStoppingCondition = null,

    /// The ARN of a training job associated with this processing job.
    training_job_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_specification = "AppSpecification",
        .auto_ml_job_arn = "AutoMLJobArn",
        .creation_time = "CreationTime",
        .environment = "Environment",
        .exit_message = "ExitMessage",
        .experiment_config = "ExperimentConfig",
        .failure_reason = "FailureReason",
        .last_modified_time = "LastModifiedTime",
        .monitoring_schedule_arn = "MonitoringScheduleArn",
        .network_config = "NetworkConfig",
        .processing_end_time = "ProcessingEndTime",
        .processing_inputs = "ProcessingInputs",
        .processing_job_arn = "ProcessingJobArn",
        .processing_job_name = "ProcessingJobName",
        .processing_job_status = "ProcessingJobStatus",
        .processing_output_config = "ProcessingOutputConfig",
        .processing_resources = "ProcessingResources",
        .processing_start_time = "ProcessingStartTime",
        .role_arn = "RoleArn",
        .stopping_condition = "StoppingCondition",
        .training_job_arn = "TrainingJobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProcessingJobInput, options: CallOptions) !DescribeProcessingJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProcessingJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeProcessingJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProcessingJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeProcessingJobOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
