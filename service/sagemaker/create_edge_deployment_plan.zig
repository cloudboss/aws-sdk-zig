const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EdgeDeploymentModelConfig = @import("edge_deployment_model_config.zig").EdgeDeploymentModelConfig;
const DeploymentStage = @import("deployment_stage.zig").DeploymentStage;
const Tag = @import("tag.zig").Tag;

pub const CreateEdgeDeploymentPlanInput = struct {
    /// The device fleet used for this edge deployment plan.
    device_fleet_name: []const u8,

    /// The name of the edge deployment plan.
    edge_deployment_plan_name: []const u8,

    /// List of models associated with the edge deployment plan.
    model_configs: []const EdgeDeploymentModelConfig,

    /// List of stages of the edge deployment plan. The number of stages is limited
    /// to 10 per deployment.
    stages: ?[]const DeploymentStage = null,

    /// List of tags with which to tag the edge deployment plan.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .device_fleet_name = "DeviceFleetName",
        .edge_deployment_plan_name = "EdgeDeploymentPlanName",
        .model_configs = "ModelConfigs",
        .stages = "Stages",
        .tags = "Tags",
    };
};

pub const CreateEdgeDeploymentPlanOutput = struct {
    /// The ARN of the edge deployment plan.
    edge_deployment_plan_arn: []const u8,

    pub const json_field_names = .{
        .edge_deployment_plan_arn = "EdgeDeploymentPlanArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEdgeDeploymentPlanInput, options: CallOptions) !CreateEdgeDeploymentPlanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEdgeDeploymentPlanInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateEdgeDeploymentPlan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEdgeDeploymentPlanOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateEdgeDeploymentPlanOutput, body, allocator);
}
