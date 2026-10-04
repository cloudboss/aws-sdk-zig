const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

pub const GetDeploymentInput = struct {
    /// The API identifier.
    api_id: []const u8,

    /// The deployment ID.
    deployment_id: []const u8,

    pub const json_field_names = .{
        .api_id = "ApiId",
        .deployment_id = "DeploymentId",
    };
};

pub const GetDeploymentOutput = struct {
    /// Specifies whether a deployment was automatically released.
    auto_deployed: ?bool = null,

    /// The date and time when the Deployment resource was created.
    created_date: ?i64 = null,

    /// The identifier for the deployment.
    deployment_id: ?[]const u8 = null,

    /// The status of the deployment: PENDING, FAILED, or SUCCEEDED.
    deployment_status: ?DeploymentStatus = null,

    /// May contain additional feedback on the status of an API deployment.
    deployment_status_message: ?[]const u8 = null,

    /// The description for the deployment.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_deployed = "AutoDeployed",
        .created_date = "CreatedDate",
        .deployment_id = "DeploymentId",
        .deployment_status = "DeploymentStatus",
        .deployment_status_message = "DeploymentStatusMessage",
        .description = "Description",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDeploymentInput, options: CallOptions) !GetDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/deployments/");
    try path_buf.appendSlice(allocator, input.deployment_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDeploymentOutput {
    var result: GetDeploymentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDeploymentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
