const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Failure = @import("failure.zig").Failure;
const ServiceDeployment = @import("service_deployment.zig").ServiceDeployment;

pub const DescribeServiceDeploymentsInput = struct {
    /// The ARN of the service deployment.
    ///
    /// You can specify a maximum of 20 ARNs.
    service_deployment_arns: []const []const u8,

    pub const json_field_names = .{
        .service_deployment_arns = "serviceDeploymentArns",
    };
};

pub const DescribeServiceDeploymentsOutput = struct {
    /// Any failures associated with the call.
    ///
    /// If you decsribe a deployment with a service revision created before October
    /// 25, 2024, the call fails. The failure includes the service revision ARN and
    /// the reason set to `MISSING`.
    failures: ?[]const Failure = null,

    /// The list of service deployments described.
    service_deployments: ?[]const ServiceDeployment = null,

    pub const json_field_names = .{
        .failures = "failures",
        .service_deployments = "serviceDeployments",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeServiceDeploymentsInput, options: CallOptions) !DescribeServiceDeploymentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeServiceDeploymentsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.DescribeServiceDeployments");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeServiceDeploymentsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeServiceDeploymentsOutput, body, allocator);
}
