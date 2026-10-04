const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ReservedNode = @import("reserved_node.zig").ReservedNode;

pub const PurchaseReservedNodesOfferingInput = struct {
    /// The number of node instances to reserve.
    node_count: ?i32 = null,

    /// A customer-specified identifier to track this reservation.
    reservation_id: ?[]const u8 = null,

    /// The ID of the reserved node offering to purchase.
    reserved_nodes_offering_id: []const u8,

    /// A list of tags to be added to this resource. A tag is a key-value pair. A
    /// tag key must be accompanied by a tag value, although null is accepted.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .node_count = "NodeCount",
        .reservation_id = "ReservationId",
        .reserved_nodes_offering_id = "ReservedNodesOfferingId",
        .tags = "Tags",
    };
};

pub const PurchaseReservedNodesOfferingOutput = struct {
    /// Represents the output of a `PurchaseReservedNodesOffering` operation.
    reserved_node: ?ReservedNode = null,

    pub const json_field_names = .{
        .reserved_node = "ReservedNode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PurchaseReservedNodesOfferingInput, options: CallOptions) !PurchaseReservedNodesOfferingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "memorydb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PurchaseReservedNodesOfferingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("memory-db", "MemoryDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.PurchaseReservedNodesOffering");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PurchaseReservedNodesOfferingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PurchaseReservedNodesOfferingOutput, body, allocator);
}
