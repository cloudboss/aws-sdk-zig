const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReservedNode = @import("reserved_node.zig").ReservedNode;
const serde = @import("serde.zig");

pub const AcceptReservedNodeExchangeInput = struct {
    /// A string representing the node identifier of the DC1 Reserved Node to be
    /// exchanged.
    reserved_node_id: []const u8,

    /// The unique identifier of the DC2 Reserved Node offering to be used for the
    /// exchange.
    /// You can obtain the value for the parameter by calling
    /// GetReservedNodeExchangeOfferings
    target_reserved_node_offering_id: []const u8,
};

pub const AcceptReservedNodeExchangeOutput = struct {
    exchanged_reserved_node: ?ReservedNode = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AcceptReservedNodeExchangeInput, options: CallOptions) !AcceptReservedNodeExchangeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AcceptReservedNodeExchangeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=AcceptReservedNodeExchange&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&ReservedNodeId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.reserved_node_id);
    try body_buf.appendSlice(allocator, "&TargetReservedNodeOfferingId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.target_reserved_node_offering_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AcceptReservedNodeExchangeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AcceptReservedNodeExchangeResult")) break;
            },
            else => {},
        }
    }

    var result: AcceptReservedNodeExchangeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExchangedReservedNode")) {
                    result.exchanged_reserved_node = try serde.deserializeReservedNode(allocator, &reader);
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
