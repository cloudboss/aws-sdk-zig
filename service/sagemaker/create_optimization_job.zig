const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOptimizationJobInput, options: CallOptions) !CreateOptimizationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOptimizationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateOptimizationJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOptimizationJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateOptimizationJobOutput, body, allocator);
}
