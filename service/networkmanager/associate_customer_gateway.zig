const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomerGatewayAssociation = @import("customer_gateway_association.zig").CustomerGatewayAssociation;

pub const AssociateCustomerGatewayInput = struct {
    /// The Amazon Resource Name (ARN) of the customer gateway.
    customer_gateway_arn: []const u8,

    /// The ID of the device.
    device_id: []const u8,

    /// The ID of the global network.
    global_network_id: []const u8,

    /// The ID of the link.
    link_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .customer_gateway_arn = "CustomerGatewayArn",
        .device_id = "DeviceId",
        .global_network_id = "GlobalNetworkId",
        .link_id = "LinkId",
    };
};

pub const AssociateCustomerGatewayOutput = struct {
    /// The customer gateway association.
    customer_gateway_association: ?CustomerGatewayAssociation = null,

    pub const json_field_names = .{
        .customer_gateway_association = "CustomerGatewayAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateCustomerGatewayInput, options: CallOptions) !AssociateCustomerGatewayOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateCustomerGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-networks/");
    try path_buf.appendSlice(allocator, input.global_network_id);
    try path_buf.appendSlice(allocator, "/customer-gateway-associations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CustomerGatewayArn\":");
    try aws.json.writeValue(@TypeOf(input.customer_gateway_arn), input.customer_gateway_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DeviceId\":");
    try aws.json.writeValue(@TypeOf(input.device_id), input.device_id, allocator, &body_buf);
    has_prev = true;
    if (input.link_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LinkId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateCustomerGatewayOutput {
    var result: AssociateCustomerGatewayOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AssociateCustomerGatewayOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
