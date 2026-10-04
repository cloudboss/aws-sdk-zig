const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WirelessGatewayIdType = @import("wireless_gateway_id_type.zig").WirelessGatewayIdType;
const LoRaWANGateway = @import("lo_ra_wan_gateway.zig").LoRaWANGateway;

pub const GetWirelessGatewayInput = struct {
    /// The identifier of the wireless gateway to get.
    identifier: []const u8,

    /// The type of identifier used in `identifier`.
    identifier_type: WirelessGatewayIdType,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .identifier_type = "IdentifierType",
    };
};

pub const GetWirelessGatewayOutput = struct {
    /// The Amazon Resource Name of the resource.
    arn: ?[]const u8 = null,

    /// The description of the resource.
    description: ?[]const u8 = null,

    /// The ID of the wireless gateway.
    id: ?[]const u8 = null,

    /// Information about the wireless gateway.
    lo_ra_wan: ?LoRaWANGateway = null,

    /// The name of the resource.
    name: ?[]const u8 = null,

    /// The ARN of the thing associated with the wireless gateway.
    thing_arn: ?[]const u8 = null,

    /// The name of the thing associated with the wireless gateway. The value is
    /// empty if a
    /// thing isn't associated with the gateway.
    thing_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .id = "Id",
        .lo_ra_wan = "LoRaWAN",
        .name = "Name",
        .thing_arn = "ThingArn",
        .thing_name = "ThingName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWirelessGatewayInput, options: CallOptions) !GetWirelessGatewayOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotwireless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWirelessGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/wireless-gateways/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "identifierType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.identifier_type.wireName());
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWirelessGatewayOutput {
    var result: GetWirelessGatewayOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetWirelessGatewayOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
