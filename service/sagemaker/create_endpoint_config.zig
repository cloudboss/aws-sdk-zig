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
const Tag = @import("tag.zig").Tag;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

pub const CreateEndpointConfigInput = struct {
    /// Specifies configuration for how an endpoint performs asynchronous inference.
    /// This is a required field in order for your Endpoint to be invoked using
    /// [InvokeEndpointAsync](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_runtime_InvokeEndpointAsync.html).
    async_inference_config: ?AsyncInferenceConfig = null,

    data_capture_config: ?DataCaptureConfig = null,

    /// Sets whether all model containers deployed to the endpoint are isolated. If
    /// they are, no inbound or outbound network calls can be made to or from the
    /// model containers.
    enable_network_isolation: ?bool = null,

    /// The name of the endpoint configuration. You specify this name in a
    /// [CreateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpoint.html) request.
    endpoint_config_name: []const u8,

    /// The Amazon Resource Name (ARN) of an IAM role that Amazon SageMaker AI can
    /// assume to perform actions on your behalf. For more information, see
    /// [SageMaker AI
    /// Roles](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-roles.html).
    ///
    /// To be able to pass this role to Amazon SageMaker AI, the caller of this
    /// action must have the `iam:PassRole` permission.
    execution_role_arn: ?[]const u8 = null,

    /// A member of `CreateEndpointConfig` that enables explainers.
    explainer_config: ?ExplainerConfig = null,

    /// The Amazon Resource Name (ARN) of a Amazon Web Services Key Management
    /// Service key that SageMaker uses to encrypt data on the storage volume
    /// attached to the ML compute instance that hosts the endpoint.
    ///
    /// The KmsKeyId can be any of the following formats:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    /// * Key ARN:
    ///   `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    /// * Alias name: `alias/ExampleAlias`
    /// * Alias name ARN: `arn:aws:kms:us-west-2:111122223333:alias/ExampleAlias`
    ///
    /// The KMS key policy must grant permission to the IAM role that you specify in
    /// your `CreateEndpoint`, `UpdateEndpoint` requests. For more information,
    /// refer to the Amazon Web Services Key Management Service section[ Using Key
    /// Policies in Amazon Web Services KMS
    /// ](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html)
    ///
    /// Certain Nitro-based instances include local storage, dependent on the
    /// instance type. Local storage volumes are encrypted using a hardware module
    /// on the instance. You can't request a `KmsKeyId` when using an instance type
    /// with local storage. If any of the models that you specify in the
    /// `ProductionVariants` parameter use nitro-based instances with local storage,
    /// do not specify a value for the `KmsKeyId` parameter. If you specify a value
    /// for `KmsKeyId` when using any nitro-based instances with local storage, the
    /// call to `CreateEndpointConfig` fails.
    ///
    /// For a list of instance types that support local instance storage, see
    /// [Instance Store
    /// Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes).
    ///
    /// For more information about local instance storage encryption, see [SSD
    /// Instance Store
    /// Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ssd-instance-store.html).
    kms_key_id: ?[]const u8 = null,

    /// The configuration parameters for utilization metrics.
    metrics_config: ?MetricsConfig = null,

    /// An array of `ProductionVariant` objects, one for each model that you want to
    /// host at this endpoint.
    production_variants: []const ProductionVariant,

    /// An array of `ProductionVariant` objects, one for each model that you want to
    /// host at this endpoint in shadow mode with production traffic replicated from
    /// the model specified on `ProductionVariants`. If you use this field, you can
    /// only specify one variant for `ProductionVariants` and one variant for
    /// `ShadowProductionVariants`.
    shadow_production_variants: ?[]const ProductionVariant = null,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    tags: ?[]const Tag = null,

    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .async_inference_config = "AsyncInferenceConfig",
        .data_capture_config = "DataCaptureConfig",
        .enable_network_isolation = "EnableNetworkIsolation",
        .endpoint_config_name = "EndpointConfigName",
        .execution_role_arn = "ExecutionRoleArn",
        .explainer_config = "ExplainerConfig",
        .kms_key_id = "KmsKeyId",
        .metrics_config = "MetricsConfig",
        .production_variants = "ProductionVariants",
        .shadow_production_variants = "ShadowProductionVariants",
        .tags = "Tags",
        .vpc_config = "VpcConfig",
    };
};

pub const CreateEndpointConfigOutput = struct {
    /// The Amazon Resource Name (ARN) of the endpoint configuration.
    endpoint_config_arn: []const u8,

    pub const json_field_names = .{
        .endpoint_config_arn = "EndpointConfigArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEndpointConfigInput, options: CallOptions) !CreateEndpointConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEndpointConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateEndpointConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEndpointConfigOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateEndpointConfigOutput, body, allocator);
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
