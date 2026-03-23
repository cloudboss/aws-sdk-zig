const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEdgeDeploymentPlanInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeEdgeDeploymentPlan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEdgeDeploymentPlanOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeEdgeDeploymentPlanOutput, body, allocator);
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
