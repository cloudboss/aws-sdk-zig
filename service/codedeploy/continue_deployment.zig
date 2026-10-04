const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeploymentWaitType = @import("deployment_wait_type.zig").DeploymentWaitType;

pub const ContinueDeploymentInput = struct {
    /// The unique ID of a blue/green deployment for which you want to start
    /// rerouting
    /// traffic to the replacement environment.
    deployment_id: ?[]const u8 = null,

    /// The status of the deployment's waiting period. `READY_WAIT` indicates that
    /// the deployment is ready to start shifting traffic. `TERMINATION_WAIT`
    /// indicates that the traffic is shifted, but the original target is not
    /// terminated.
    deployment_wait_type: ?DeploymentWaitType = null,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .deployment_wait_type = "deploymentWaitType",
    };
};

pub const ContinueDeploymentOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ContinueDeploymentInput, options: CallOptions) !ContinueDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codedeploy", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ContinueDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codedeploy", "CodeDeploy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.ContinueDeployment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ContinueDeploymentOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
