const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VPCRegion = @import("vpc_region.zig").VPCRegion;
const HostedZoneSummary = @import("hosted_zone_summary.zig").HostedZoneSummary;
const serde = @import("serde.zig");

pub const ListHostedZonesByVPCInput = struct {
    /// (Optional) The maximum number of hosted zones that you want Amazon Route 53
    /// to return.
    /// If the specified VPC is associated with more than `MaxItems` hosted zones,
    /// the response includes a `NextToken` element. `NextToken` contains
    /// an encrypted token that identifies the first hosted zone that Route 53 will
    /// return if
    /// you submit another request.
    max_items: ?i32 = null,

    /// If the previous response included a `NextToken` element, the specified VPC
    /// is associated with more hosted zones. To get more hosted zones, submit
    /// another
    /// `ListHostedZonesByVPC` request.
    ///
    /// For the value of `NextToken`, specify the value of `NextToken`
    /// from the previous response.
    ///
    /// If the previous response didn't include a `NextToken` element, there are no
    /// more hosted zones to get.
    next_token: ?[]const u8 = null,

    /// The ID of the Amazon VPC that you want to list hosted zones for.
    vpc_id: []const u8,

    /// For the Amazon VPC that you specified for `VPCId`, the Amazon Web Services
    /// Region that you created the VPC in.
    vpc_region: VPCRegion,
};

pub const ListHostedZonesByVPCOutput = struct {
    /// A list that contains one `HostedZoneSummary` element for each hosted zone
    /// that the specified Amazon VPC is associated with. Each `HostedZoneSummary`
    /// element contains the hosted zone name and ID, and information about who owns
    /// the hosted
    /// zone.
    hosted_zone_summaries: ?[]const HostedZoneSummary = null,

    /// The value that you specified for `MaxItems` in the most recent
    /// `ListHostedZonesByVPC` request.
    max_items: i32,

    /// The value that you will use for `NextToken` in the next
    /// `ListHostedZonesByVPC` request.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListHostedZonesByVPCInput, options: CallOptions) !ListHostedZonesByVPCOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListHostedZonesByVPCInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/hostedzonesbyvpc";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxitems=");
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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "vpcid=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.vpc_id);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "vpcregion=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.vpc_region.wireName());
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListHostedZonesByVPCOutput {
    var result: ListHostedZonesByVPCOutput = undefined;
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
                if (std.mem.eql(u8, e.local, "HostedZoneSummaries")) {
                    result.hosted_zone_summaries = try serde.deserializeHostedZoneSummaries(allocator, &reader, "HostedZoneSummary");
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
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
