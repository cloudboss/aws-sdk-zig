const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpamRouteOriginAuthorizationInfo = @import("ipam_route_origin_authorization_info.zig").IpamRouteOriginAuthorizationInfo;
const serde = @import("serde.zig");

pub const GetIpamRouteOriginAuthorizationsInput = struct {
    /// Filter results to a specific CIDR prefix.
    cidr: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the operation, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the IPAM internet registry association.
    ipam_internet_registry_association_id: []const u8,

    /// The maximum number of results to return in a single call. If not specified,
    /// all available results are returned. To retrieve the remaining results, make
    /// another call with the returned `nextToken` value.
    max_results: ?i32 = null,

    /// The token for the next page of results.
    next_token: ?[]const u8 = null,
};

pub const GetIpamRouteOriginAuthorizationsOutput = struct {
    /// The Route Origin Authorizations published to the RPKI.
    ipam_route_origin_authorizations: ?[]const IpamRouteOriginAuthorizationInfo = null,

    /// The token to use to retrieve the next page of results.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIpamRouteOriginAuthorizationsInput, options: CallOptions) !GetIpamRouteOriginAuthorizationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ec2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIpamRouteOriginAuthorizationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetIpamRouteOriginAuthorizations&Version=2016-11-15");
    if (input.cidr) |v| {
        try body_buf.appendSlice(allocator, "&Cidr=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&IpamInternetRegistryAssociationId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ipam_internet_registry_association_id);
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIpamRouteOriginAuthorizationsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetIpamRouteOriginAuthorizationsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipamRouteOriginAuthorizationSet")) {
                    result.ipam_route_origin_authorizations = try serde.deserializeIpamRouteOriginAuthorizationInfoSet(allocator, &reader, "item");
                } else if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
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
