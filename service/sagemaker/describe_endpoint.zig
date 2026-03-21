const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AsyncInferenceConfig = @import("async_inference_config.zig").AsyncInferenceConfig;
const DataCaptureConfigSummary = @import("data_capture_config_summary.zig").DataCaptureConfigSummary;
const EndpointStatus = @import("endpoint_status.zig").EndpointStatus;
const ExplainerConfig = @import("explainer_config.zig").ExplainerConfig;
const DeploymentConfig = @import("deployment_config.zig").DeploymentConfig;
const MetricsConfig = @import("metrics_config.zig").MetricsConfig;
const PendingDeploymentSummary = @import("pending_deployment_summary.zig").PendingDeploymentSummary;
const ProductionVariantSummary = @import("production_variant_summary.zig").ProductionVariantSummary;

pub const DescribeEndpointInput = struct {
    /// The name of the endpoint.
    endpoint_name: []const u8,

    pub const json_field_names = .{
        .endpoint_name = "EndpointName",
    };
};

pub const DescribeEndpointOutput = struct {
    /// Returns the description of an endpoint configuration created using the [
    /// `CreateEndpointConfig`
    /// ](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpointConfig.html) API.
    async_inference_config: ?AsyncInferenceConfig = null,

    /// A timestamp that shows when the endpoint was created.
    creation_time: i64,

    data_capture_config: ?DataCaptureConfigSummary = null,

    /// The Amazon Resource Name (ARN) of the endpoint.
    endpoint_arn: []const u8,

    /// The name of the endpoint configuration associated with this endpoint.
    endpoint_config_name: ?[]const u8 = null,

    /// Name of the endpoint.
    endpoint_name: []const u8,

    /// The status of the endpoint.
    ///
    /// * `OutOfService`: Endpoint is not available to take incoming requests.
    /// * `Creating`:
    ///   [CreateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateEndpoint.html) is executing.
    /// * `Updating`:
    ///   [UpdateEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateEndpoint.html) or [UpdateEndpointWeightsAndCapacities](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateEndpointWeightsAndCapacities.html) is executing.
    /// * `SystemUpdating`: Endpoint is undergoing maintenance and cannot be updated
    ///   or deleted or re-scaled until it has completed. This maintenance operation
    ///   does not change any customer-specified values such as VPC config, KMS
    ///   encryption, model, instance type, or instance count.
    /// * `RollingBack`: Endpoint fails to scale up or down or change its variant
    ///   weight and is in the process of rolling back to its previous
    ///   configuration. Once the rollback completes, endpoint returns to an
    ///   `InService` status. This transitional status only applies to an endpoint
    ///   that has autoscaling enabled and is undergoing variant weight or capacity
    ///   changes as part of an
    ///   [UpdateEndpointWeightsAndCapacities](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateEndpointWeightsAndCapacities.html) call or when the [UpdateEndpointWeightsAndCapacities](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_UpdateEndpointWeightsAndCapacities.html) operation is called explicitly.
    /// * `InService`: Endpoint is available to process incoming requests.
    /// * `Deleting`:
    ///   [DeleteEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DeleteEndpoint.html) is executing.
    /// * `Failed`: Endpoint could not be created, updated, or re-scaled. Use the
    ///   `FailureReason` value returned by
    ///   [DescribeEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeEndpoint.html) for information about the failure. [DeleteEndpoint](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DeleteEndpoint.html) is the only operation that can be performed on a failed endpoint.
    /// * `UpdateRollbackFailed`: Both the rolling deployment and auto-rollback
    ///   failed. Your endpoint is in service with a mix of the old and new endpoint
    ///   configurations. For information about how to remedy this issue and restore
    ///   the endpoint's status to `InService`, see [Rolling
    ///   Deployments](https://docs.aws.amazon.com/sagemaker/latest/dg/deployment-guardrails-rolling.html).
    endpoint_status: EndpointStatus,

    /// The configuration parameters for an explainer.
    explainer_config: ?ExplainerConfig = null,

    /// If the status of the endpoint is `Failed`, the reason why it failed.
    failure_reason: ?[]const u8 = null,

    /// The most recent deployment configuration for the endpoint.
    last_deployment_config: ?DeploymentConfig = null,

    /// A timestamp that shows when the endpoint was last modified.
    last_modified_time: i64,

    /// The configuration parameters for utilization metrics.
    metrics_config: ?MetricsConfig = null,

    /// Returns the summary of an in-progress deployment. This field is only
    /// returned when the endpoint is creating or updating with a new endpoint
    /// configuration.
    pending_deployment_summary: ?PendingDeploymentSummary = null,

    /// An array of
    /// [ProductionVariantSummary](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ProductionVariantSummary.html) objects, one for each model hosted behind this endpoint.
    production_variants: ?[]const ProductionVariantSummary = null,

    /// An array of
    /// [ProductionVariantSummary](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ProductionVariantSummary.html) objects, one for each model that you want to host at this endpoint in shadow mode with production traffic replicated from the model specified on `ProductionVariants`.
    shadow_production_variants: ?[]const ProductionVariantSummary = null,

    pub const json_field_names = .{
        .async_inference_config = "AsyncInferenceConfig",
        .creation_time = "CreationTime",
        .data_capture_config = "DataCaptureConfig",
        .endpoint_arn = "EndpointArn",
        .endpoint_config_name = "EndpointConfigName",
        .endpoint_name = "EndpointName",
        .endpoint_status = "EndpointStatus",
        .explainer_config = "ExplainerConfig",
        .failure_reason = "FailureReason",
        .last_deployment_config = "LastDeploymentConfig",
        .last_modified_time = "LastModifiedTime",
        .metrics_config = "MetricsConfig",
        .pending_deployment_summary = "PendingDeploymentSummary",
        .production_variants = "ProductionVariants",
        .shadow_production_variants = "ShadowProductionVariants",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEndpointInput, options: CallOptions) !DescribeEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEndpointInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEndpointOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeEndpointOutput, body, allocator);
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
