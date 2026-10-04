const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NewTransitVirtualInterface = @import("new_transit_virtual_interface.zig").NewTransitVirtualInterface;
const VirtualInterface = @import("virtual_interface.zig").VirtualInterface;

pub const CreateTransitVirtualInterfaceInput = struct {
    /// The ID of the connection.
    connection_id: []const u8,

    /// Information about the transit virtual interface.
    new_transit_virtual_interface: NewTransitVirtualInterface,

    pub const json_field_names = .{
        .connection_id = "connectionId",
        .new_transit_virtual_interface = "newTransitVirtualInterface",
    };
};

pub const CreateTransitVirtualInterfaceOutput = struct {
    /// Information about a virtual interface.
    virtual_interface: ?VirtualInterface = null,

    pub const json_field_names = .{
        .virtual_interface = "virtualInterface",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTransitVirtualInterfaceInput, options: CallOptions) !CreateTransitVirtualInterfaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "directconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTransitVirtualInterfaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("directconnect", "Direct Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "OvertureService.CreateTransitVirtualInterface");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTransitVirtualInterfaceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTransitVirtualInterfaceOutput, body, allocator);
}
