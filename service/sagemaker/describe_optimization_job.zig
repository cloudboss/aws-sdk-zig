const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const OptimizationJobDeploymentInstanceType = @import("optimization_job_deployment_instance_type.zig").OptimizationJobDeploymentInstanceType;
const OptimizationJobModelSource = @import("optimization_job_model_source.zig").OptimizationJobModelSource;
const OptimizationConfig = @import("optimization_config.zig").OptimizationConfig;
const OptimizationJobStatus = @import("optimization_job_status.zig").OptimizationJobStatus;
const OptimizationOutput = @import("optimization_output.zig").OptimizationOutput;
const OptimizationJobOutputConfig = @import("optimization_job_output_config.zig").OptimizationJobOutputConfig;
const StoppingCondition = @import("stopping_condition.zig").StoppingCondition;
const OptimizationVpcConfig = @import("optimization_vpc_config.zig").OptimizationVpcConfig;

pub const DescribeOptimizationJobInput = struct {
    /// The name that you assigned to the optimization job.
    optimization_job_name: []const u8,

    pub const json_field_names = .{
        .optimization_job_name = "OptimizationJobName",
    };
};

pub const DescribeOptimizationJobOutput = struct {
    /// The time when you created the optimization job.
    creation_time: i64,

    /// The type of instance that hosts the optimized model that you create with the
    /// optimization job.
    deployment_instance_type: OptimizationJobDeploymentInstanceType,

    /// If the optimization job status is `FAILED`, the reason for the failure.
    failure_reason: ?[]const u8 = null,

    /// The time when the optimization job was last updated.
    last_modified_time: i64,

    /// The maximum number of instances to use for the optimization job.
    max_instance_count: ?i32 = null,

    /// The location of the source model to optimize with an optimization job.
    model_source: ?OptimizationJobModelSource = null,

    /// Settings for each of the optimization techniques that the job applies.
    optimization_configs: ?[]const OptimizationConfig = null,

    /// The time when the optimization job finished processing.
    optimization_end_time: ?i64 = null,

    /// The environment variables to set in the model container.
    optimization_environment: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the optimization job.
    optimization_job_arn: []const u8,

    /// The name that you assigned to the optimization job.
    optimization_job_name: []const u8,

    /// The current status of the optimization job.
    optimization_job_status: OptimizationJobStatus,

    /// Output values produced by an optimization job.
    optimization_output: ?OptimizationOutput = null,

    /// The time when the optimization job started.
    optimization_start_time: ?i64 = null,

    /// Details for where to store the optimized model that you create with the
    /// optimization job.
    output_config: ?OptimizationJobOutputConfig = null,

    /// The ARN of the IAM role that you assigned to the optimization job.
    role_arn: []const u8,

    stopping_condition: ?StoppingCondition = null,

    /// A VPC in Amazon VPC that your optimized model has access to.
    vpc_config: ?OptimizationVpcConfig = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .deployment_instance_type = "DeploymentInstanceType",
        .failure_reason = "FailureReason",
        .last_modified_time = "LastModifiedTime",
        .max_instance_count = "MaxInstanceCount",
        .model_source = "ModelSource",
        .optimization_configs = "OptimizationConfigs",
        .optimization_end_time = "OptimizationEndTime",
        .optimization_environment = "OptimizationEnvironment",
        .optimization_job_arn = "OptimizationJobArn",
        .optimization_job_name = "OptimizationJobName",
        .optimization_job_status = "OptimizationJobStatus",
        .optimization_output = "OptimizationOutput",
        .optimization_start_time = "OptimizationStartTime",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
        .stopping_condition = "StoppingCondition",
        .vpc_config = "VpcConfig",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeOptimizationJobInput, options: Options) !DescribeOptimizationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeOptimizationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeOptimizationJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeOptimizationJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeOptimizationJobOutput, body, allocator);
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
