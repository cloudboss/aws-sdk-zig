const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceField = @import("service_field.zig").ServiceField;
const Failure = @import("failure.zig").Failure;
const Service = @import("service.zig").Service;

pub const DescribeServicesInput = struct {
    /// The short name or full Amazon Resource Name (ARN)the cluster that hosts the
    /// service to describe. If you do not specify a cluster, the default cluster is
    /// assumed. This parameter is required if the service or services you are
    /// describing were launched in any cluster other than the default cluster.
    cluster: ?[]const u8 = null,

    /// Determines whether you want to see the resource tags for the service. If
    /// `TAGS` is specified, the tags are included in the response. If this field is
    /// omitted, tags aren't included in the response.
    include: ?[]const ServiceField = null,

    /// A list of services to describe. You may specify up to 10 services to
    /// describe in a single operation.
    services: []const []const u8,

    pub const json_field_names = .{
        .cluster = "cluster",
        .include = "include",
        .services = "services",
    };
};

pub const DescribeServicesOutput = struct {
    /// Any failures associated with the call.
    failures: ?[]const Failure = null,

    /// The list of services described.
    services: ?[]const Service = null,

    pub const json_field_names = .{
        .failures = "failures",
        .services = "services",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeServicesInput, options: CallOptions) !DescribeServicesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeServicesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.DescribeServices");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeServicesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeServicesOutput, body, allocator);
}
