const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const OptimizationJobDeploymentInstanceType = @import("optimization_job_deployment_instance_type.zig").OptimizationJobDeploymentInstanceType;
const OptimizationJobModelSource = @import("optimization_job_model_source.zig").OptimizationJobModelSource;
const OptimizationConfig = @import("optimization_config.zig").OptimizationConfig;
const OptimizationJobOutputConfig = @import("optimization_job_output_config.zig").OptimizationJobOutputConfig;
const StoppingCondition = @import("stopping_condition.zig").StoppingCondition;
const Tag = @import("tag.zig").Tag;
const OptimizationVpcConfig = @import("optimization_vpc_config.zig").OptimizationVpcConfig;

pub const CreateOptimizationJobInput = struct {
    /// The type of instance that hosts the optimized model that you create with the
    /// optimization job.
    deployment_instance_type: OptimizationJobDeploymentInstanceType,

    /// The maximum number of instances to use for the optimization job.
    max_instance_count: ?i32 = null,

    /// The location of the source model to optimize with an optimization job.
    model_source: OptimizationJobModelSource,

    /// Settings for each of the optimization techniques that the job applies.
    optimization_configs: []const OptimizationConfig,

    /// The environment variables to set in the model container.
    optimization_environment: ?[]const aws.map.StringMapEntry = null,

    /// A custom name for the new optimization job.
    optimization_job_name: []const u8,

    /// Details for where to store the optimized model that you create with the
    /// optimization job.
    output_config: OptimizationJobOutputConfig,

    /// The Amazon Resource Name (ARN) of an IAM role that enables Amazon SageMaker
    /// AI to perform tasks on your behalf.
    ///
    /// During model optimization, Amazon SageMaker AI needs your permission to:
    ///
    /// * Read input data from an S3 bucket
    /// * Write model artifacts to an S3 bucket
    /// * Write logs to Amazon CloudWatch Logs
    /// * Publish metrics to Amazon CloudWatch
    ///
    /// You grant permissions for all of these tasks to an IAM role. To pass this
    /// role to Amazon SageMaker AI, the caller of this API must have the
    /// `iam:PassRole` permission. For more information, see [Amazon SageMaker AI
    /// Roles.](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-roles.html)
    role_arn: []const u8,

    stopping_condition: StoppingCondition,

    /// A list of key-value pairs associated with the optimization job. For more
    /// information, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference Guide*.
    tags: ?[]const Tag = null,

    /// A VPC in Amazon VPC that your optimized model has access to.
    vpc_config: ?OptimizationVpcConfig = null,

    pub const json_field_names = .{
        .deployment_instance_type = "DeploymentInstanceType",
        .max_instance_count = "MaxInstanceCount",
        .model_source = "ModelSource",
        .optimization_configs = "OptimizationConfigs",
        .optimization_environment = "OptimizationEnvironment",
        .optimization_job_name = "OptimizationJobName",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
        .stopping_condition = "StoppingCondition",
        .tags = "Tags",
        .vpc_config = "VpcConfig",
    };
};

pub const CreateOptimizationJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the optimization job.
    optimization_job_arn: []const u8,

    pub const json_field_names = .{
        .optimization_job_arn = "OptimizationJobArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOptimizationJobInput, options: Options) !CreateOptimizationJobOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateOptimizationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.CreateOptimizationJob");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateOptimizationJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateOptimizationJobOutput, body, alloc);
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
