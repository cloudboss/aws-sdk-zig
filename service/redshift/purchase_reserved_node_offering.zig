const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReservedNode = @import("reserved_node.zig").ReservedNode;
const serde = @import("serde.zig");

pub const PurchaseReservedNodeOfferingInput = struct {
    /// The number of reserved nodes that you want to purchase.
    ///
    /// Default: `1`
    node_count: ?i32 = null,

    /// The unique identifier of the reserved node offering you want to purchase.
    reserved_node_offering_id: []const u8,
};

pub const PurchaseReservedNodeOfferingOutput = struct {
    reserved_node: ?ReservedNode = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PurchaseReservedNodeOfferingInput, options: CallOptions) !PurchaseReservedNodeOfferingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PurchaseReservedNodeOfferingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=PurchaseReservedNodeOffering&Version=2012-12-01");
    if (input.node_count) |v| {
        try body_buf.appendSlice(allocator, "&NodeCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(allocator, "&ReservedNodeOfferingId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.reserved_node_offering_id);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PurchaseReservedNodeOfferingOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PurchaseReservedNodeOfferingResult")) break;
            },
            else => {},
        }
    }

    var result: PurchaseReservedNodeOfferingOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ReservedNode")) {
                    result.reserved_node = try serde.deserializeReservedNode(allocator, &reader);
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
