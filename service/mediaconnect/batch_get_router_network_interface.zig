const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchGetRouterNetworkInterfaceError = @import("batch_get_router_network_interface_error.zig").BatchGetRouterNetworkInterfaceError;
const RouterNetworkInterface = @import("router_network_interface.zig").RouterNetworkInterface;

pub const BatchGetRouterNetworkInterfaceInput = struct {
    /// The Amazon Resource Names (ARNs) of the router network interfaces you want
    /// to retrieve information about.
    arns: []const []const u8,

    pub const json_field_names = .{
        .arns = "Arns",
    };
};

pub const BatchGetRouterNetworkInterfaceOutput = struct {
    /// An array of errors that occurred when retrieving the requested router
    /// network interfaces.
    errors: ?[]const BatchGetRouterNetworkInterfaceError = null,

    /// An array of router network interfaces that were successfully retrieved.
    router_network_interfaces: ?[]const RouterNetworkInterface = null,

    pub const json_field_names = .{
        .errors = "Errors",
        .router_network_interfaces = "RouterNetworkInterfaces",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetRouterNetworkInterfaceInput, options: CallOptions) !BatchGetRouterNetworkInterfaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetRouterNetworkInterfaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/routerNetworkInterfaces";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    for (input.arns) |item| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "arns=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, item);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetRouterNetworkInterfaceOutput {
    var result: BatchGetRouterNetworkInterfaceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetRouterNetworkInterfaceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
