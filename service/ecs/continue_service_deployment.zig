const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeploymentLifecycleHookAction = @import("deployment_lifecycle_hook_action.zig").DeploymentLifecycleHookAction;

pub const ContinueServiceDeploymentInput = struct {
    /// The action to take on the paused lifecycle hook. Valid values are:
    ///
    /// * `CONTINUE` - Proceeds the deployment to the next lifecycle stage.
    /// * `ROLLBACK` - Rolls back the deployment to the previous service revision.
    ///
    /// If no value is specified, the default action is `CONTINUE`.
    action: ?DeploymentLifecycleHookAction = null,

    /// The ID of the paused lifecycle hook to act on. You can find the `hookId` by
    /// calling
    /// [DescribeServiceDeployments](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DescribeServiceDeployments.html) and inspecting the `lifecycleHookDetails` field of the service deployment.
    hook_id: []const u8,

    /// The ARN of the service deployment to continue or roll back.
    service_deployment_arn: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .hook_id = "hookId",
        .service_deployment_arn = "serviceDeploymentArn",
    };
};

pub const ContinueServiceDeploymentOutput = struct {
    /// The ARN of the service deployment that was continued or rolled back.
    service_deployment_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .service_deployment_arn = "serviceDeploymentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ContinueServiceDeploymentInput, options: CallOptions) !ContinueServiceDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ContinueServiceDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.ContinueServiceDeployment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ContinueServiceDeploymentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ContinueServiceDeploymentOutput, body, allocator);
}
