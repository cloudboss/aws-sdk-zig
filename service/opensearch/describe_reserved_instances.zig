const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReservedInstance = @import("reserved_instance.zig").ReservedInstance;

pub const DescribeReservedInstancesInput = struct {
    /// An optional parameter that specifies the maximum number of results to
    /// return. You can
    /// use `nextToken` to get the next page of results.
    max_results: ?i32 = null,

    /// If your initial `DescribeReservedInstances` operation returns a
    /// `nextToken`, you can include the returned `nextToken` in
    /// subsequent `DescribeReservedInstances` operations, which returns results in
    /// the next page.
    next_token: ?[]const u8 = null,

    /// The reserved instance identifier filter value. Use this parameter to show
    /// only the
    /// reservation that matches the specified reserved OpenSearch instance ID.
    reserved_instance_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .reserved_instance_id = "ReservedInstanceId",
    };
};

pub const DescribeReservedInstancesOutput = struct {
    /// When `nextToken` is returned, there are more results available. The value
    /// of `nextToken` is a unique pagination token for each page. Send the request
    /// again using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// List of Reserved Instances in the current Region.
    reserved_instances: ?[]const ReservedInstance = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .reserved_instances = "ReservedInstances",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReservedInstancesInput, options: CallOptions) !DescribeReservedInstancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReservedInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/opensearch/reservedInstances";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.reserved_instance_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "reservationId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReservedInstancesOutput {
    var result: DescribeReservedInstancesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeReservedInstancesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
