const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Service = @import("service.zig").Service;

pub const DeleteServiceInput = struct {
    /// The short name or full Amazon Resource Name (ARN) of the cluster that hosts
    /// the service to delete. If you do not specify a cluster, the default cluster
    /// is assumed.
    cluster: ?[]const u8 = null,

    /// If `true`, allows you to delete a service even if it wasn't scaled down to
    /// zero tasks. It's only necessary to use this if the service uses the
    /// `REPLICA` scheduling strategy.
    force: ?bool = null,

    /// The name of the service to delete.
    service: []const u8,

    pub const json_field_names = .{
        .cluster = "cluster",
        .force = "force",
        .service = "service",
    };
};

pub const DeleteServiceOutput = struct {
    /// The full description of the deleted service.
    service: ?Service = null,

    pub const json_field_names = .{
        .service = "service",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteServiceInput, options: CallOptions) !DeleteServiceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteServiceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.DeleteService");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteServiceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteServiceOutput, body, allocator);
}
