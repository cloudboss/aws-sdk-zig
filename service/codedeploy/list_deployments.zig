const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TimeRange = @import("time_range.zig").TimeRange;
const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

pub const ListDeploymentsInput = struct {
    /// The name of an CodeDeploy application associated with the user or Amazon Web
    /// Services account.
    ///
    /// If `applicationName` is specified, then
    /// `deploymentGroupName` must be specified. If it is not specified, then
    /// `deploymentGroupName` must not be specified.
    application_name: ?[]const u8 = null,

    /// A time range (start and end) for returning a subset of the list of
    /// deployments.
    create_time_range: ?TimeRange = null,

    /// The name of a deployment group for the specified application.
    ///
    /// If `deploymentGroupName` is specified, then
    /// `applicationName` must be specified. If it is not specified, then
    /// `applicationName` must not be specified.
    deployment_group_name: ?[]const u8 = null,

    /// The unique ID of an external resource for returning deployments linked to
    /// the external
    /// resource.
    external_id: ?[]const u8 = null,

    /// A subset of deployments to list by status:
    ///
    /// * `Created`: Include created deployments in the resulting
    /// list.
    ///
    /// * `Queued`: Include queued deployments in the resulting list.
    ///
    /// * `In Progress`: Include in-progress deployments in the resulting
    /// list.
    ///
    /// * `Succeeded`: Include successful deployments in the resulting
    /// list.
    ///
    /// * `Failed`: Include failed deployments in the resulting list.
    ///
    /// * `Stopped`: Include stopped deployments in the resulting
    /// list.
    include_only_statuses: ?[]const DeploymentStatus = null,

    /// An identifier returned from the previous list deployments call. It can be
    /// used to
    /// return the next set of deployments in the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_name = "applicationName",
        .create_time_range = "createTimeRange",
        .deployment_group_name = "deploymentGroupName",
        .external_id = "externalId",
        .include_only_statuses = "includeOnlyStatuses",
        .next_token = "nextToken",
    };
};

pub const ListDeploymentsOutput = struct {
    /// A list of deployment IDs.
    deployments: ?[]const []const u8 = null,

    /// If a large amount of information is returned, an identifier is also
    /// returned. It can
    /// be used in a subsequent list deployments call to return the next set of
    /// deployments in
    /// the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployments = "deployments",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDeploymentsInput, options: CallOptions) !ListDeploymentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDeploymentsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.ListDeployments");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDeploymentsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDeploymentsOutput, body, allocator);
}
