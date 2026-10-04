const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListDeploymentTargetsInput = struct {
    /// The unique ID of a deployment.
    deployment_id: []const u8,

    /// A token identifier returned from the previous `ListDeploymentTargets`
    /// call. It can be used to return the next set of deployment targets in the
    /// list.
    next_token: ?[]const u8 = null,

    /// A key used to filter the returned targets. The two valid values are:
    ///
    /// * `TargetStatus` - A `TargetStatus` filter string can be
    /// `Failed`, `InProgress`, `Pending`,
    /// `Ready`, `Skipped`, `Succeeded`, or
    /// `Unknown`.
    ///
    /// * `ServerInstanceLabel` - A `ServerInstanceLabel` filter
    /// string can be `Blue` or `Green`.
    target_filters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .next_token = "nextToken",
        .target_filters = "targetFilters",
    };
};

pub const ListDeploymentTargetsOutput = struct {
    /// If a large amount of information is returned, a token identifier is also
    /// returned. It
    /// can be used in a subsequent `ListDeploymentTargets` call to return the next
    /// set of deployment targets in the list.
    next_token: ?[]const u8 = null,

    /// The unique IDs of deployment targets.
    target_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .target_ids = "targetIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDeploymentTargetsInput, options: CallOptions) !ListDeploymentTargetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDeploymentTargetsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.ListDeploymentTargets");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDeploymentTargetsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDeploymentTargetsOutput, body, allocator);
}
