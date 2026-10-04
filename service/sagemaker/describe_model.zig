const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContainerDefinition = @import("container_definition.zig").ContainerDefinition;
const DeploymentRecommendation = @import("deployment_recommendation.zig").DeploymentRecommendation;
const InferenceExecutionConfig = @import("inference_execution_config.zig").InferenceExecutionConfig;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

pub const DescribeModelInput = struct {
    /// The name of the model.
    model_name: []const u8,

    pub const json_field_names = .{
        .model_name = "ModelName",
    };
};

pub const DescribeModelOutput = struct {
    /// The containers in the inference pipeline.
    containers: ?[]const ContainerDefinition = null,

    /// A timestamp that shows when the model was created.
    creation_time: i64,

    /// A set of recommended deployment configurations for the model.
    deployment_recommendation: ?DeploymentRecommendation = null,

    /// If `True`, no inbound or outbound network calls can be made to or from the
    /// model container.
    enable_network_isolation: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM role that you specified for the
    /// model.
    execution_role_arn: ?[]const u8 = null,

    /// Specifies details of how containers in a multi-container endpoint are
    /// called.
    inference_execution_config: ?InferenceExecutionConfig = null,

    /// The Amazon Resource Name (ARN) of the model.
    model_arn: []const u8,

    /// Name of the SageMaker model.
    model_name: []const u8,

    /// The location of the primary inference code, associated artifacts, and custom
    /// environment map that the inference code uses when it is deployed in
    /// production.
    primary_container: ?ContainerDefinition = null,

    /// A
    /// [VpcConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_VpcConfig.html) object that specifies the VPC that this model has access to. For more information, see [Protect Endpoints by Using an Amazon Virtual Private Cloud](https://docs.aws.amazon.com/sagemaker/latest/dg/host-vpc.html)
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .containers = "Containers",
        .creation_time = "CreationTime",
        .deployment_recommendation = "DeploymentRecommendation",
        .enable_network_isolation = "EnableNetworkIsolation",
        .execution_role_arn = "ExecutionRoleArn",
        .inference_execution_config = "InferenceExecutionConfig",
        .model_arn = "ModelArn",
        .model_name = "ModelName",
        .primary_container = "PrimaryContainer",
        .vpc_config = "VpcConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeModelInput, options: CallOptions) !DescribeModelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeModelInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeModel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeModelOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeModelOutput, body, allocator);
}
