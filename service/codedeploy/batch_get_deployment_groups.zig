const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeploymentGroupInfo = @import("deployment_group_info.zig").DeploymentGroupInfo;

pub const BatchGetDeploymentGroupsInput = struct {
    /// The name of an CodeDeploy application associated with the applicable user
    /// or Amazon Web Services account.
    application_name: []const u8,

    /// The names of the deployment groups.
    deployment_group_names: []const []const u8,

    pub const json_field_names = .{
        .application_name = "applicationName",
        .deployment_group_names = "deploymentGroupNames",
    };
};

pub const BatchGetDeploymentGroupsOutput = struct {
    /// Information about the deployment groups.
    deployment_groups_info: ?[]const DeploymentGroupInfo = null,

    /// Information about errors that might have occurred during the API call.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_groups_info = "deploymentGroupsInfo",
        .error_message = "errorMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetDeploymentGroupsInput, options: CallOptions) !BatchGetDeploymentGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetDeploymentGroupsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.BatchGetDeploymentGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetDeploymentGroupsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetDeploymentGroupsOutput, body, allocator);
}
