const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RouterNetworkInterfaceState = @import("router_network_interface_state.zig").RouterNetworkInterfaceState;

pub const DeleteRouterNetworkInterfaceInput = struct {
    /// The Amazon Resource Name (ARN) of the router network interface that you want
    /// to delete.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const DeleteRouterNetworkInterfaceOutput = struct {
    /// The ARN of the deleted router network interface.
    arn: []const u8,

    /// The name of the deleted router network interface.
    name: []const u8,

    /// The current state of the deleted router network interface, indicating where
    /// it is in the deletion process.
    state: RouterNetworkInterfaceState,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteRouterNetworkInterfaceInput, options: CallOptions) !DeleteRouterNetworkInterfaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteRouterNetworkInterfaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/routerNetworkInterface/");
    try path_buf.appendSlice(allocator, input.arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteRouterNetworkInterfaceOutput {
    const result: DeleteRouterNetworkInterfaceOutput = try aws.json.parseJsonObject(
        DeleteRouterNetworkInterfaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
