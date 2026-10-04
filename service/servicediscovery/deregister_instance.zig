const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeregisterInstanceInput = struct {
    /// The value that you specified for `Id` in the
    /// [RegisterInstance](https://docs.aws.amazon.com/cloud-map/latest/api/API_RegisterInstance.html) request.
    instance_id: []const u8,

    /// The ID or Amazon Resource Name (ARN) of the service that the instance is
    /// associated with. If the namespace
    /// associated with the service is shared with your account, specify the service
    /// ARN. For more
    /// information about shared namespaces, see [Cross-account Cloud Map namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the
    /// *Cloud Map Developer Guide*.
    service_id: []const u8,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .service_id = "ServiceId",
    };
};

pub const DeregisterInstanceOutput = struct {
    /// A value that you can use to determine whether the request completed
    /// successfully.
    /// To get the status of the operation, see
    /// [GetOperation](https://docs.aws.amazon.com/cloud-map/latest/api/API_GetOperation.html).
    operation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .operation_id = "OperationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeregisterInstanceInput, options: CallOptions) !DeregisterInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeregisterInstanceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53AutoNaming_v20170314.DeregisterInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeregisterInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeregisterInstanceOutput, body, allocator);
}
