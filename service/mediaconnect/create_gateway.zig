const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GatewayNetwork = @import("gateway_network.zig").GatewayNetwork;
const Gateway = @import("gateway.zig").Gateway;

pub const CreateGatewayInput = struct {
    /// The range of IP addresses that are allowed to contribute content or initiate
    /// output requests for flows communicating with this gateway. These IP
    /// addresses should be in the form of a Classless Inter-Domain Routing (CIDR)
    /// block; for example, 10.0.0.0/16.
    egress_cidr_blocks: []const []const u8,

    /// The name of the gateway. This name can not be modified after the gateway is
    /// created.
    name: []const u8,

    /// The list of networks that you want to add to the gateway.
    networks: []const GatewayNetwork,

    pub const json_field_names = .{
        .egress_cidr_blocks = "EgressCidrBlocks",
        .name = "Name",
        .networks = "Networks",
    };
};

pub const CreateGatewayOutput = struct {
    /// The gateway that you created.
    gateway: ?Gateway = null,

    pub const json_field_names = .{
        .gateway = "Gateway",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGatewayInput, options: CallOptions) !CreateGatewayOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/gateways";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EgressCidrBlocks\":");
    try aws.json.writeValue(@TypeOf(input.egress_cidr_blocks), input.egress_cidr_blocks, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Networks\":");
    try aws.json.writeValue(@TypeOf(input.networks), input.networks, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGatewayOutput {
    const result: CreateGatewayOutput = try aws.json.parseJsonObject(
        CreateGatewayOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
