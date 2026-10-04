const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InferenceComponentDeploymentConfig = @import("inference_component_deployment_config.zig").InferenceComponentDeploymentConfig;
const InferenceComponentRuntimeConfig = @import("inference_component_runtime_config.zig").InferenceComponentRuntimeConfig;
const InferenceComponentSpecification = @import("inference_component_specification.zig").InferenceComponentSpecification;

pub const UpdateInferenceComponentInput = struct {
    /// The deployment configuration for the inference component. The configuration
    /// contains the desired deployment strategy and rollback settings.
    deployment_config: ?InferenceComponentDeploymentConfig = null,

    /// The name of the inference component.
    inference_component_name: []const u8,

    /// Runtime settings for a model that is deployed with an inference component.
    runtime_config: ?InferenceComponentRuntimeConfig = null,

    /// Details about the resources to deploy with this inference component,
    /// including the model, container, and compute resources.
    specification: ?InferenceComponentSpecification = null,

    /// A list of specification objects for the inference component, one per
    /// instance type. Use this parameter when you want to specify different model
    /// or resource configurations for the inference component on each instance
    /// type. You can use either this parameter or the singular `Specification`
    /// parameter, but not both.
    specifications: ?[]const InferenceComponentSpecification = null,

    pub const json_field_names = .{
        .deployment_config = "DeploymentConfig",
        .inference_component_name = "InferenceComponentName",
        .runtime_config = "RuntimeConfig",
        .specification = "Specification",
        .specifications = "Specifications",
    };
};

pub const UpdateInferenceComponentOutput = struct {
    /// The Amazon Resource Name (ARN) of the inference component.
    inference_component_arn: []const u8,

    pub const json_field_names = .{
        .inference_component_arn = "InferenceComponentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateInferenceComponentInput, options: CallOptions) !UpdateInferenceComponentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateInferenceComponentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateInferenceComponent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateInferenceComponentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateInferenceComponentOutput, body, allocator);
}
