const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const LocalGatewayRoute = @import("local_gateway_route.zig").LocalGatewayRoute;
const serde = @import("serde.zig");

/// Modifies the specified local gateway route.
pub const ModifyLocalGatewayRouteInput = struct {
    /// The CIDR block used for destination matches. The value that you provide must
    /// match the CIDR of an existing route in the table.
    destination_cidr_block: ?[]const u8 = null,

    /// The ID of the prefix list. Use a prefix list in place of
    /// `DestinationCidrBlock`. You
    /// cannot use `DestinationPrefixListId` and `DestinationCidrBlock` in the same
    /// request.
    destination_prefix_list_id: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the local gateway route table.
    local_gateway_route_table_id: []const u8,

    /// The ID of the virtual interface group.
    local_gateway_virtual_interface_group_id: ?[]const u8 = null,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8 = null,
};

pub const ModifyLocalGatewayRouteOutput = struct {
    /// Information about the local gateway route table.
    route: ?LocalGatewayRoute = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyLocalGatewayRouteOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyLocalGatewayRouteInput, options: Options) !ModifyLocalGatewayRouteOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyLocalGatewayRouteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyLocalGatewayRoute&Version=2016-11-15");
    if (input.destination_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&DestinationCidrBlock=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_prefix_list_id) |v| {
        try body_buf.appendSlice(alloc, "&DestinationPrefixListId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&LocalGatewayRouteTableId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.local_gateway_route_table_id);
    if (input.local_gateway_virtual_interface_group_id) |v| {
        try body_buf.appendSlice(alloc, "&LocalGatewayVirtualInterfaceGroupId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.network_interface_id) |v| {
        try body_buf.appendSlice(alloc, "&NetworkInterfaceId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyLocalGatewayRouteOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyLocalGatewayRouteOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "route")) {
                    result.route = try serde.deserializeLocalGatewayRoute(&reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
