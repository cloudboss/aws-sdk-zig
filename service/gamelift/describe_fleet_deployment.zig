const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FleetDeployment = @import("fleet_deployment.zig").FleetDeployment;
const LocationalDeployment = @import("locational_deployment.zig").LocationalDeployment;

pub const DescribeFleetDeploymentInput = struct {
    /// A unique identifier for the deployment to return information for.
    deployment_id: ?[]const u8 = null,

    /// A unique identifier for the container fleet. You can use either the fleet ID
    /// or ARN
    /// value.
    fleet_id: []const u8,

    pub const json_field_names = .{
        .deployment_id = "DeploymentId",
        .fleet_id = "FleetId",
    };
};

pub const DescribeFleetDeploymentOutput = struct {
    /// The requested deployment information.
    fleet_deployment: ?FleetDeployment = null,

    /// If the deployment is for a multi-location fleet, the requests returns the
    /// deployment
    /// status in each fleet location.
    locational_deployments: ?[]const aws.map.MapEntry(LocationalDeployment) = null,

    pub const json_field_names = .{
        .fleet_deployment = "FleetDeployment",
        .locational_deployments = "LocationalDeployments",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFleetDeploymentInput, options: CallOptions) !DescribeFleetDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFleetDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.DescribeFleetDeployment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFleetDeploymentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFleetDeploymentOutput, body, allocator);
}
