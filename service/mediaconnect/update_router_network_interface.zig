const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RouterNetworkInterfaceConfiguration = @import("router_network_interface_configuration.zig").RouterNetworkInterfaceConfiguration;
const RouterNetworkInterface = @import("router_network_interface.zig").RouterNetworkInterface;

pub const UpdateRouterNetworkInterfaceInput = struct {
    /// The Amazon Resource Name (ARN) of the router network interface that you want
    /// to update.
    arn: []const u8,

    /// The updated configuration settings for the router network interface.
    /// Changing the type of the configuration is not supported.
    configuration: ?RouterNetworkInterfaceConfiguration = null,

    /// The updated name for the router network interface.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .configuration = "Configuration",
        .name = "Name",
    };
};

pub const UpdateRouterNetworkInterfaceOutput = struct {
    /// The updated router network interface.
    router_network_interface: ?RouterNetworkInterface = null,

    pub const json_field_names = .{
        .router_network_interface = "RouterNetworkInterface",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRouterNetworkInterfaceInput, options: CallOptions) !UpdateRouterNetworkInterfaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRouterNetworkInterfaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/routerNetworkInterface/");
    try path_buf.appendSlice(allocator, input.arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRouterNetworkInterfaceOutput {
    const result: UpdateRouterNetworkInterfaceOutput = try aws.json.parseJsonObject(
        UpdateRouterNetworkInterfaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
