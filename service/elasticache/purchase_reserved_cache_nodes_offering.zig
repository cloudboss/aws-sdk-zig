const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ReservedCacheNode = @import("reserved_cache_node.zig").ReservedCacheNode;
const serde = @import("serde.zig");

pub const PurchaseReservedCacheNodesOfferingInput = struct {
    /// The number of cache node instances to reserve.
    ///
    /// Default: `1`
    cache_node_count: ?i32 = null,

    /// A customer-specified identifier to track this reservation.
    ///
    /// The Reserved Cache Node ID is an unique customer-specified identifier to
    /// track
    /// this reservation. If this parameter is not specified, ElastiCache
    /// automatically
    /// generates an identifier for the reservation.
    ///
    /// Example: myreservationID
    reserved_cache_node_id: ?[]const u8 = null,

    /// The ID of the reserved cache node offering to purchase.
    ///
    /// Example: `438012d3-4052-4cc7-b2e3-8d3372e0e706`
    reserved_cache_nodes_offering_id: []const u8,

    /// A list of tags to be added to this resource. A tag is a key-value pair. A
    /// tag key must
    /// be accompanied by a tag value, although null is accepted.
    tags: ?[]const Tag = null,
};

pub const PurchaseReservedCacheNodesOfferingOutput = struct {
    reserved_cache_node: ?ReservedCacheNode = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PurchaseReservedCacheNodesOfferingInput, options: CallOptions) !PurchaseReservedCacheNodesOfferingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticache", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PurchaseReservedCacheNodesOfferingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=PurchaseReservedCacheNodesOffering&Version=2015-02-02");
    if (input.cache_node_count) |v| {
        try body_buf.appendSlice(allocator, "&CacheNodeCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.reserved_cache_node_id) |v| {
        try body_buf.appendSlice(allocator, "&ReservedCacheNodeId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&ReservedCacheNodesOfferingId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.reserved_cache_nodes_offering_id);
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PurchaseReservedCacheNodesOfferingOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PurchaseReservedCacheNodesOfferingResult")) break;
            },
            else => {},
        }
    }

    var result: PurchaseReservedCacheNodesOfferingOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ReservedCacheNode")) {
                    result.reserved_cache_node = try serde.deserializeReservedCacheNode(allocator, &reader);
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
