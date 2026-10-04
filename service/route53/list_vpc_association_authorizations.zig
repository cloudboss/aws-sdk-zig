const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VPC = @import("vpc.zig").VPC;
const serde = @import("serde.zig");

pub const ListVPCAssociationAuthorizationsInput = struct {
    /// The ID of the hosted zone for which you want a list of VPCs that can be
    /// associated
    /// with the hosted zone.
    hosted_zone_id: []const u8,

    /// *Optional*: An integer that specifies the maximum number of VPCs
    /// that you want Amazon Route 53 to return. If you don't specify a value for
    /// `MaxResults`, Route 53 returns up to 50 VPCs per page.
    max_results: ?i32 = null,

    /// *Optional*: If a response includes a `NextToken`
    /// element, there are more VPCs that can be associated with the specified
    /// hosted zone. To
    /// get the next page of results, submit another request, and include the value
    /// of
    /// `NextToken` from the response in the `nexttoken` parameter in
    /// another `ListVPCAssociationAuthorizations` request.
    next_token: ?[]const u8 = null,
};

pub const ListVPCAssociationAuthorizationsOutput = struct {
    /// The ID of the hosted zone that you can associate the listed VPCs with.
    hosted_zone_id: []const u8,

    /// When the response includes a `NextToken` element, there are more VPCs that
    /// can be associated with the specified hosted zone. To get the next page of
    /// VPCs, submit
    /// another `ListVPCAssociationAuthorizations` request, and include the value of
    /// the `NextToken` element from the response in the `nexttoken`
    /// request parameter.
    next_token: ?[]const u8 = null,

    /// The list of VPCs that are authorized to be associated with the specified
    /// hosted
    /// zone.
    vp_cs: ?[]const VPC = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListVPCAssociationAuthorizationsInput, options: CallOptions) !ListVPCAssociationAuthorizationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListVPCAssociationAuthorizationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/hostedzone/");
    try path_buf.appendSlice(allocator, input.hosted_zone_id);
    try path_buf.appendSlice(allocator, "/authorizevpcassociation");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxresults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nexttoken=");
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListVPCAssociationAuthorizationsOutput {
    var result: ListVPCAssociationAuthorizationsOutput = undefined;
    result.next_token = null;
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VPCs")) {
                    result.vp_cs = try serde.deserializeVPCs(allocator, &reader, "VPC");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}
