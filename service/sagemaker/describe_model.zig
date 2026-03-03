const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeModelInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeModel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeModelOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeModelOutput, body, allocator);
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
