const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EdgeDeploymentModelConfig = @import("edge_deployment_model_config.zig").EdgeDeploymentModelConfig;
const DeploymentStageStatusSummary = @import("deployment_stage_status_summary.zig").DeploymentStageStatusSummary;

pub const DescribeEdgeDeploymentPlanInput = struct {
    /// The name of the deployment plan to describe.
    edge_deployment_plan_name: []const u8,

    /// The maximum number of results to select (50 by default).
    max_results: ?i32 = null,

    /// If the edge deployment plan has enough stages to require tokening, then this
    /// is the response from the last list of stages returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .edge_deployment_plan_name = "EdgeDeploymentPlanName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeEdgeDeploymentPlanOutput = struct {
    /// The time when the edge deployment plan was created.
    creation_time: ?i64 = null,

    /// The device fleet used for this edge deployment plan.
    device_fleet_name: []const u8,

    /// The number of edge devices that failed the deployment.
    edge_deployment_failed: ?i32 = null,

    /// The number of edge devices yet to pick up deployment, or in progress.
    edge_deployment_pending: ?i32 = null,

    /// The ARN of edge deployment plan.
    edge_deployment_plan_arn: []const u8,

    /// The name of the edge deployment plan.
    edge_deployment_plan_name: []const u8,

    /// The number of edge devices with the successful deployment.
    edge_deployment_success: ?i32 = null,

    /// The time when the edge deployment plan was last updated.
    last_modified_time: ?i64 = null,

    /// List of models associated with the edge deployment plan.
    model_configs: ?[]const EdgeDeploymentModelConfig = null,

    /// Token to use when calling the next set of stages in the edge deployment
    /// plan.
    next_token: ?[]const u8 = null,

    /// List of stages in the edge deployment plan.
    stages: ?[]const DeploymentStageStatusSummary = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .device_fleet_name = "DeviceFleetName",
        .edge_deployment_failed = "EdgeDeploymentFailed",
        .edge_deployment_pending = "EdgeDeploymentPending",
        .edge_deployment_plan_arn = "EdgeDeploymentPlanArn",
        .edge_deployment_plan_name = "EdgeDeploymentPlanName",
        .edge_deployment_success = "EdgeDeploymentSuccess",
        .last_modified_time = "LastModifiedTime",
        .model_configs = "ModelConfigs",
        .next_token = "NextToken",
        .stages = "Stages",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEdgeDeploymentPlanInput, options: CallOptions) !DescribeEdgeDeploymentPlanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEdgeDeploymentPlanInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeEdgeDeploymentPlan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEdgeDeploymentPlanOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeEdgeDeploymentPlanOutput, body, allocator);
}
