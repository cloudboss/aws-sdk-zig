const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomHealthStatus = @import("custom_health_status.zig").CustomHealthStatus;

pub const UpdateInstanceCustomHealthStatusInput = struct {
    /// The ID of the instance that you want to change the health status for.
    instance_id: []const u8,

    /// The ID or Amazon Resource Name (ARN) of the service that includes the
    /// configuration for the custom health
    /// check that you want to change the status for. For services created in a
    /// shared namespace, specify
    /// the service ARN. For more information about shared namespaces, see
    /// [Cross-account Cloud Map
    /// namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the *Cloud Map Developer Guide*.
    service_id: []const u8,

    /// The new status of the instance, `HEALTHY` or `UNHEALTHY`.
    status: CustomHealthStatus,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .service_id = "ServiceId",
        .status = "Status",
    };
};

pub const UpdateInstanceCustomHealthStatusOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateInstanceCustomHealthStatusInput, options: CallOptions) !UpdateInstanceCustomHealthStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicediscovery", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateInstanceCustomHealthStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicediscovery", "ServiceDiscovery", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53AutoNaming_v20170314.UpdateInstanceCustomHealthStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateInstanceCustomHealthStatusOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
