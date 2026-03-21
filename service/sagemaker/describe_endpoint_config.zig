const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AsyncInferenceConfig = @import("async_inference_config.zig").AsyncInferenceConfig;
const DataCaptureConfig = @import("data_capture_config.zig").DataCaptureConfig;
const ExplainerConfig = @import("explainer_config.zig").ExplainerConfig;
const MetricsConfig = @import("metrics_config.zig").MetricsConfig;
const ProductionVariant = @import("production_variant.zig").ProductionVariant;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

pub const DescribeEndpointConfigInput = struct {
    /// The name of the endpoint configuration.
    endpoint_config_name: []const u8,

    pub const json_field_names = .{
        .endpoint_config_name = "EndpointConfigName",
    };
};

pub const DescribeEndpointConfigOutput = struct {
    /// Returns the description of an endpoint configuration created using the [
    /// `CreateEndpointConfig`
    /// ](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpointConfig.html) API.
    async_inference_config: ?AsyncInferenceConfig = null,

    /// A timestamp that shows when the endpoint configuration was created.
    creation_time: i64,

    data_capture_config: ?DataCaptureConfig = null,

    /// Indicates whether all model containers deployed to the endpoint are
    /// isolated. If they are, no inbound or outbound network calls can be made to
    /// or from the model containers.
    enable_network_isolation: ?bool = null,

    /// The Amazon Resource Name (ARN) of the endpoint configuration.
    endpoint_config_arn: []const u8,

    /// Name of the SageMaker endpoint configuration.
    endpoint_config_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that you assigned to the
    /// endpoint configuration.
    execution_role_arn: ?[]const u8 = null,

    /// The configuration parameters for an explainer.
    explainer_config: ?ExplainerConfig = null,

    /// Amazon Web Services KMS key ID Amazon SageMaker uses to encrypt data when
    /// storing it on the ML storage volume attached to the instance.
    kms_key_id: ?[]const u8 = null,

    /// The configuration parameters for utilization metrics.
    metrics_config: ?MetricsConfig = null,

    /// An array of `ProductionVariant` objects, one for each model that you want to
    /// host at this endpoint.
    production_variants: ?[]const ProductionVariant = null,

    /// An array of `ProductionVariant` objects, one for each model that you want to
    /// host at this endpoint in shadow mode with production traffic replicated from
    /// the model specified on `ProductionVariants`.
    shadow_production_variants: ?[]const ProductionVariant = null,

    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .async_inference_config = "AsyncInferenceConfig",
        .creation_time = "CreationTime",
        .data_capture_config = "DataCaptureConfig",
        .enable_network_isolation = "EnableNetworkIsolation",
        .endpoint_config_arn = "EndpointConfigArn",
        .endpoint_config_name = "EndpointConfigName",
        .execution_role_arn = "ExecutionRoleArn",
        .explainer_config = "ExplainerConfig",
        .kms_key_id = "KmsKeyId",
        .metrics_config = "MetricsConfig",
        .production_variants = "ProductionVariants",
        .shadow_production_variants = "ShadowProductionVariants",
        .vpc_config = "VpcConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEndpointConfigInput, options: CallOptions) !DescribeEndpointConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEndpointConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeEndpointConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEndpointConfigOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeEndpointConfigOutput, body, allocator);
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
