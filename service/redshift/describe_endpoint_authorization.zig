const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointAuthorization = @import("endpoint_authorization.zig").EndpointAuthorization;
const serde = @import("serde.zig");

pub const DescribeEndpointAuthorizationInput = struct {
    /// The Amazon Web Services account ID of either the cluster owner (grantor) or
    /// grantee.
    /// If `Grantee` parameter is true, then the `Account` value is of the grantor.
    account: ?[]const u8 = null,

    /// The cluster identifier of the cluster to access.
    cluster_identifier: ?[]const u8 = null,

    /// Indicates whether to check authorization from a grantor or grantee point of
    /// view.
    /// If true, Amazon Redshift returns endpoint authorizations that you've been
    /// granted.
    /// If false (default), checks authorization from a grantor point of view.
    grantee: ?bool = null,

    /// An optional pagination token provided by a previous
    /// `DescribeEndpointAuthorization` request. If this parameter is specified, the
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
};

pub const DescribeEndpointAuthorizationOutput = struct {
    /// The authorizations to an endpoint.
    endpoint_authorization_list: ?[]const EndpointAuthorization = null,

    /// An optional pagination token provided by a previous
    /// `DescribeEndpointAuthorization` request. If this parameter is specified, the
    /// response includes only records beyond the marker, up to the value specified
    /// by the
    /// `MaxRecords` parameter.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEndpointAuthorizationInput, options: CallOptions) !DescribeEndpointAuthorizationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEndpointAuthorizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeEndpointAuthorization&Version=2012-12-01");
    if (input.account) |v| {
        try body_buf.appendSlice(allocator, "&Account=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.grantee) |v| {
        try body_buf.appendSlice(allocator, "&Grantee=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEndpointAuthorizationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeEndpointAuthorizationResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeEndpointAuthorizationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EndpointAuthorizationList")) {
                    result.endpoint_authorization_list = try serde.deserializeEndpointAuthorizations(allocator, &reader, "member");
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
