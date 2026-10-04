const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HostedZone = @import("hosted_zone.zig").HostedZone;
const serde = @import("serde.zig");

pub const ListHostedZonesByNameInput = struct {
    /// (Optional) For your first request to `ListHostedZonesByName`, include the
    /// `dnsname` parameter only if you want to specify the name of the first
    /// hosted zone in the response. If you don't include the `dnsname` parameter,
    /// Amazon Route 53 returns all of the hosted zones that were created by the
    /// current Amazon Web Services account, in ASCII order. For subsequent
    /// requests, include both
    /// `dnsname` and `hostedzoneid` parameters. For
    /// `dnsname`, specify the value of `NextDNSName` from the
    /// previous response.
    dns_name: ?[]const u8 = null,

    /// (Optional) For your first request to `ListHostedZonesByName`, do not
    /// include the `hostedzoneid` parameter.
    ///
    /// If you have more hosted zones than the value of `maxitems`,
    /// `ListHostedZonesByName` returns only the first `maxitems`
    /// hosted zones. To get the next group of `maxitems` hosted zones, submit
    /// another request to `ListHostedZonesByName` and include both
    /// `dnsname` and `hostedzoneid` parameters. For the value of
    /// `hostedzoneid`, specify the value of the `NextHostedZoneId`
    /// element from the previous response.
    hosted_zone_id: ?[]const u8 = null,

    /// The maximum number of hosted zones to be included in the response body for
    /// this
    /// request. If you have more than `maxitems` hosted zones, then the value of
    /// the
    /// `IsTruncated` element in the response is true, and the values of
    /// `NextDNSName` and `NextHostedZoneId` specify the first hosted
    /// zone in the next group of `maxitems` hosted zones.
    max_items: ?i32 = null,
};

pub const ListHostedZonesByNameOutput = struct {
    /// For the second and subsequent calls to `ListHostedZonesByName`,
    /// `DNSName` is the value that you specified for the `dnsname`
    /// parameter in the request that produced the current response.
    dns_name: ?[]const u8 = null,

    /// The ID that Amazon Route 53 assigned to the hosted zone when you created it.
    hosted_zone_id: ?[]const u8 = null,

    /// A complex type that contains general information about the hosted zone.
    hosted_zones: ?[]const HostedZone = null,

    /// A flag that indicates whether there are more hosted zones to be listed. If
    /// the
    /// response was truncated, you can get the next group of `maxitems` hosted
    /// zones
    /// by calling `ListHostedZonesByName` again and specifying the values of
    /// `NextDNSName` and `NextHostedZoneId` elements in the
    /// `dnsname` and `hostedzoneid` parameters.
    is_truncated: ?bool = null,

    /// The value that you specified for the `maxitems` parameter in the call to
    /// `ListHostedZonesByName` that produced the current response.
    max_items: i32,

    /// If `IsTruncated` is true, the value of `NextDNSName` is the name
    /// of the first hosted zone in the next group of `maxitems` hosted zones. Call
    /// `ListHostedZonesByName` again and specify the value of
    /// `NextDNSName` and `NextHostedZoneId` in the
    /// `dnsname` and `hostedzoneid` parameters, respectively.
    ///
    /// This element is present only if `IsTruncated` is `true`.
    next_dns_name: ?[]const u8 = null,

    /// If `IsTruncated` is `true`, the value of
    /// `NextHostedZoneId` identifies the first hosted zone in the next group of
    /// `maxitems` hosted zones. Call `ListHostedZonesByName` again
    /// and specify the value of `NextDNSName` and `NextHostedZoneId` in
    /// the `dnsname` and `hostedzoneid` parameters, respectively.
    ///
    /// This element is present only if `IsTruncated` is `true`.
    next_hosted_zone_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListHostedZonesByNameInput, options: CallOptions) !ListHostedZonesByNameOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListHostedZonesByNameInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/hostedzonesbyname";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.dns_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "dnsname=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.hosted_zone_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "hostedzoneid=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxitems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListHostedZonesByNameOutput {
    var result: ListHostedZonesByNameOutput = undefined;
    result.dns_name = null;
    result.hosted_zone_id = null;
    result.next_dns_name = null;
    result.next_hosted_zone_id = null;
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
                if (std.mem.eql(u8, e.local, "DNSName")) {
                    result.dns_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HostedZoneId")) {
                    result.hosted_zone_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HostedZones")) {
                    result.hosted_zones = try serde.deserializeHostedZones(allocator, &reader, "HostedZone");
                } else if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextDNSName")) {
                    result.next_dns_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NextHostedZoneId")) {
                    result.next_hosted_zone_id = try allocator.dupe(u8, try reader.readElementText());
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
