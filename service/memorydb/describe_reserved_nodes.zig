const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReservedNode = @import("reserved_node.zig").ReservedNode;

pub const DescribeReservedNodesInput = struct {
    /// The duration filter value, specified in years or seconds. Use this parameter
    /// to show only reservations for this duration.
    duration: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the specified MaxRecords value, a marker is included in the
    /// response so that the remaining results can be retrieved.
    max_results: ?i32 = null,

    /// An optional marker returned from a prior request. Use this marker for
    /// pagination of results from this operation. If this parameter is specified,
    /// the response includes only records beyond the marker, up to the value
    /// specified by MaxRecords.
    next_token: ?[]const u8 = null,

    /// The node type filter value. Use this parameter to show only those
    /// reservations matching the specified node type. For more information, see
    /// [Supported node
    /// types](https://docs.aws.amazon.com/memorydb/latest/devguide/nodes.reserved.html#reserved-nodes-supported).
    node_type: ?[]const u8 = null,

    /// The offering type filter value. Use this parameter to show only the
    /// available offerings matching the specified offering type.
    /// Valid values: "All Upfront"|"Partial Upfront"| "No Upfront"
    offering_type: ?[]const u8 = null,

    /// The reserved node identifier filter value. Use this parameter to show only
    /// the reservation that matches the specified reservation ID.
    reservation_id: ?[]const u8 = null,

    /// The offering identifier filter value. Use this parameter to show only
    /// purchased reservations matching the specified offering identifier.
    reserved_nodes_offering_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .duration = "Duration",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .node_type = "NodeType",
        .offering_type = "OfferingType",
        .reservation_id = "ReservationId",
        .reserved_nodes_offering_id = "ReservedNodesOfferingId",
    };
};

pub const DescribeReservedNodesOutput = struct {
    /// An optional marker returned from a prior request. Use this marker for
    /// pagination of results from this operation. If this parameter is specified,
    /// the response includes only records beyond the marker, up to the value
    /// specified by MaxRecords.
    next_token: ?[]const u8 = null,

    /// Returns information about reserved nodes for this account, or about a
    /// specified reserved node.
    reserved_nodes: ?[]const ReservedNode = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .reserved_nodes = "ReservedNodes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReservedNodesInput, options: CallOptions) !DescribeReservedNodesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReservedNodesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.DescribeReservedNodes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReservedNodesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeReservedNodesOutput, body, allocator);
}
