const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Container = @import("container.zig").Container;
const EndpointRequest = @import("endpoint_request.zig").EndpointRequest;
const ContainerService = @import("container_service.zig").ContainerService;

pub const CreateContainerServiceDeploymentInput = struct {
    /// An object that describes the settings of the containers that will be
    /// launched on the
    /// container service.
    containers: ?[]const aws.map.MapEntry(Container) = null,

    /// An object that describes the settings of the public endpoint for the
    /// container
    /// service.
    public_endpoint: ?EndpointRequest = null,

    /// The name of the container service for which to create the deployment.
    service_name: []const u8,

    pub const json_field_names = .{
        .containers = "containers",
        .public_endpoint = "publicEndpoint",
        .service_name = "serviceName",
    };
};

pub const CreateContainerServiceDeploymentOutput = struct {
    /// An object that describes a container service.
    container_service: ?ContainerService = null,

    pub const json_field_names = .{
        .container_service = "containerService",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateContainerServiceDeploymentInput, options: CallOptions) !CreateContainerServiceDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateContainerServiceDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.CreateContainerServiceDeployment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateContainerServiceDeploymentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateContainerServiceDeploymentOutput, body, allocator);
}
