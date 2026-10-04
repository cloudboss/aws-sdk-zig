const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceStatus = @import("instance_status.zig").InstanceStatus;
const InstanceType = @import("instance_type.zig").InstanceType;

pub const ListDeploymentInstancesInput = struct {
    /// The unique ID of a deployment.
    deployment_id: []const u8,

    /// A subset of instances to list by status:
    ///
    /// * `Pending`: Include those instances with pending deployments.
    ///
    /// * `InProgress`: Include those instances where deployments are still
    /// in progress.
    ///
    /// * `Succeeded`: Include those instances with successful
    /// deployments.
    ///
    /// * `Failed`: Include those instances with failed deployments.
    ///
    /// * `Skipped`: Include those instances with skipped deployments.
    ///
    /// * `Unknown`: Include those instances with deployments in an unknown
    /// state.
    instance_status_filter: ?[]const InstanceStatus = null,

    /// The set of instances in a blue/green deployment, either those in the
    /// original
    /// environment ("BLUE") or those in the replacement environment ("GREEN"), for
    /// which you
    /// want to view instance information.
    instance_type_filter: ?[]const InstanceType = null,

    /// An identifier returned from the previous list deployment instances call. It
    /// can be
    /// used to return the next set of deployment instances in the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .instance_status_filter = "instanceStatusFilter",
        .instance_type_filter = "instanceTypeFilter",
        .next_token = "nextToken",
    };
};

pub const ListDeploymentInstancesOutput = struct {
    /// A list of instance IDs.
    instances_list: ?[]const []const u8 = null,

    /// If a large amount of information is returned, an identifier is also
    /// returned. It can
    /// be used in a subsequent list deployment instances call to return the next
    /// set of
    /// deployment instances in the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .instances_list = "instancesList",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDeploymentInstancesInput, options: CallOptions) !ListDeploymentInstancesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDeploymentInstancesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.ListDeploymentInstances");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDeploymentInstancesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDeploymentInstancesOutput, body, allocator);
}
