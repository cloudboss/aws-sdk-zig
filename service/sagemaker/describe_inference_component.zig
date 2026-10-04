const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InferenceComponentStatus = @import("inference_component_status.zig").InferenceComponentStatus;
const InferenceComponentDeploymentConfig = @import("inference_component_deployment_config.zig").InferenceComponentDeploymentConfig;
const InferenceComponentRuntimeConfigSummary = @import("inference_component_runtime_config_summary.zig").InferenceComponentRuntimeConfigSummary;
const InferenceComponentSpecificationSummary = @import("inference_component_specification_summary.zig").InferenceComponentSpecificationSummary;

pub const DescribeInferenceComponentInput = struct {
    /// The name of the inference component.
    inference_component_name: []const u8,

    pub const json_field_names = .{
        .inference_component_name = "InferenceComponentName",
    };
};

pub const DescribeInferenceComponentOutput = struct {
    /// The time when the inference component was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the endpoint that hosts the inference
    /// component.
    endpoint_arn: []const u8,

    /// The name of the endpoint that hosts the inference component.
    endpoint_name: []const u8,

    /// If the inference component status is `Failed`, the reason for the failure.
    failure_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the inference component.
    inference_component_arn: []const u8,

    /// The name of the inference component.
    inference_component_name: []const u8,

    /// The status of the inference component.
    inference_component_status: ?InferenceComponentStatus = null,

    /// The deployment and rollback settings that you assigned to the inference
    /// component.
    last_deployment_config: ?InferenceComponentDeploymentConfig = null,

    /// The time when the inference component was last updated.
    last_modified_time: i64,

    /// Details about the runtime settings for the model that is deployed with the
    /// inference component.
    runtime_config: ?InferenceComponentRuntimeConfigSummary = null,

    /// Details about the resources that are deployed with this inference component.
    specification: ?InferenceComponentSpecificationSummary = null,

    /// A list of specification summaries for the inference component, one per
    /// instance type. This parameter is populated when the inference component was
    /// created with multiple specifications. When this parameter is populated, the
    /// singular `Specification` parameter is not returned.
    specifications: ?[]const InferenceComponentSpecificationSummary = null,

    /// The name of the production variant that hosts the inference component.
    variant_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .endpoint_arn = "EndpointArn",
        .endpoint_name = "EndpointName",
        .failure_reason = "FailureReason",
        .inference_component_arn = "InferenceComponentArn",
        .inference_component_name = "InferenceComponentName",
        .inference_component_status = "InferenceComponentStatus",
        .last_deployment_config = "LastDeploymentConfig",
        .last_modified_time = "LastModifiedTime",
        .runtime_config = "RuntimeConfig",
        .specification = "Specification",
        .specifications = "Specifications",
        .variant_name = "VariantName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInferenceComponentInput, options: CallOptions) !DescribeInferenceComponentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInferenceComponentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeInferenceComponent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInferenceComponentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeInferenceComponentOutput, body, allocator);
}
