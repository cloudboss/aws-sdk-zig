const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceSummary = @import("instance_summary.zig").InstanceSummary;

pub const BatchGetDeploymentInstancesInput = struct {
    /// The unique ID of a deployment.
    deployment_id: []const u8,

    /// The unique IDs of instances used in the deployment. The maximum number of
    /// instance IDs
    /// you can specify is 25.
    instance_ids: []const []const u8,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .instance_ids = "instanceIds",
    };
};

pub const BatchGetDeploymentInstancesOutput = struct {
    /// Information about errors that might have occurred during the API call.
    error_message: ?[]const u8 = null,

    /// Information about the instance.
    instances_summary: ?[]const InstanceSummary = null,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .instances_summary = "instancesSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetDeploymentInstancesInput, options: CallOptions) !BatchGetDeploymentInstancesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetDeploymentInstancesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.BatchGetDeploymentInstances");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetDeploymentInstancesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetDeploymentInstancesOutput, body, allocator);
}
