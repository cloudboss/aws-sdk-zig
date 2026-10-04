const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoScalingGroup = @import("auto_scaling_group.zig").AutoScalingGroup;

pub const DeleteDeploymentGroupInput = struct {
    /// The name of an CodeDeploy application associated with the user or Amazon Web
    /// Services account.
    application_name: []const u8,

    /// The name of a deployment group for the specified application.
    deployment_group_name: []const u8,

    pub const json_field_names = .{
        .application_name = "applicationName",
        .deployment_group_name = "deploymentGroupName",
    };
};

pub const DeleteDeploymentGroupOutput = struct {
    /// If the output contains no data, and the corresponding deployment group
    /// contained at
    /// least one Auto Scaling group, CodeDeploy successfully removed all
    /// corresponding Auto Scaling lifecycle event hooks from the Amazon EC2
    /// instances in the Auto Scaling group. If the output contains data, CodeDeploy
    /// could not remove some Auto Scaling lifecycle event hooks from
    /// the Amazon EC2 instances in the Auto Scaling group.
    hooks_not_cleaned_up: ?[]const AutoScalingGroup = null,

    pub const json_field_names = .{
        .hooks_not_cleaned_up = "hooksNotCleanedUp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDeploymentGroupInput, options: CallOptions) !DeleteDeploymentGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDeploymentGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.DeleteDeploymentGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDeploymentGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteDeploymentGroupOutput, body, allocator);
}
