const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointAccess = @import("endpoint_access.zig").EndpointAccess;
const serde = @import("serde.zig");

pub const DescribeEndpointAccessInput = struct {
    /// The cluster identifier associated with the described endpoint.
    cluster_identifier: ?[]const u8 = null,

    /// The name of the endpoint to be described.
    endpoint_name: ?[]const u8 = null,

    /// An optional pagination token provided by a previous
    /// `DescribeEndpointAccess` request. If this parameter is specified, the
    /// response includes only records beyond the marker, up to the value specified
    /// by the
    /// `MaxRecords` parameter.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist
    /// than the specified `MaxRecords` value, a pagination token called a `Marker`
    /// is
    /// included in the response so that the remaining results can be retrieved.
    max_records: ?i32 = null,

    /// The Amazon Web Services account ID of the owner of the cluster.
    resource_owner: ?[]const u8 = null,

    /// The virtual private cloud (VPC) identifier with access to the cluster.
    vpc_id: ?[]const u8 = null,
};

pub const DescribeEndpointAccessOutput = struct {
    /// The list of endpoints with access to the cluster.
    endpoint_access_list: ?[]const EndpointAccess = null,

    /// An optional pagination token provided by a previous
    /// `DescribeEndpointAccess` request. If this parameter is specified, the
    /// response includes only records beyond the marker, up to the value specified
    /// by the
    /// `MaxRecords` parameter.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEndpointAccessInput, options: CallOptions) !DescribeEndpointAccessOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEndpointAccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeEndpointAccess&Version=2012-12-01");
    if (input.cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.endpoint_name) |v| {
        try body_buf.appendSlice(allocator, "&EndpointName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.resource_owner) |v| {
        try body_buf.appendSlice(allocator, "&ResourceOwner=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.vpc_id) |v| {
        try body_buf.appendSlice(allocator, "&VpcId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEndpointAccessOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeEndpointAccessResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeEndpointAccessOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EndpointAccessList")) {
                    result.endpoint_access_list = try serde.deserializeEndpointAccesses(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
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
