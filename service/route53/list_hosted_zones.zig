const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HostedZoneType = @import("hosted_zone_type.zig").HostedZoneType;
const HostedZone = @import("hosted_zone.zig").HostedZone;
const serde = @import("serde.zig");

pub const ListHostedZonesInput = struct {
    /// If you're using reusable delegation sets and you want to list all of the
    /// hosted zones
    /// that are associated with a reusable delegation set, specify the ID of that
    /// reusable
    /// delegation set.
    delegation_set_id: ?[]const u8 = null,

    /// (Optional) Specifies if the hosted zone is private.
    hosted_zone_type: ?HostedZoneType = null,

    /// If the value of `IsTruncated` in the previous response was
    /// `true`, you have more hosted zones. To get more hosted zones, submit
    /// another `ListHostedZones` request.
    ///
    /// For the value of `marker`, specify the value of `NextMarker`
    /// from the previous response, which is the ID of the first hosted zone that
    /// Amazon Route
    /// 53 will return if you submit another request.
    ///
    /// If the value of `IsTruncated` in the previous response was
    /// `false`, there are no more hosted zones to get.
    marker: ?[]const u8 = null,

    /// (Optional) The maximum number of hosted zones that you want Amazon Route 53
    /// to return.
    /// If you have more than `maxitems` hosted zones, the value of
    /// `IsTruncated` in the response is `true`, and the value of
    /// `NextMarker` is the hosted zone ID of the first hosted zone that Route 53
    /// will return if you submit another request.
    max_items: ?i32 = null,
};

pub const ListHostedZonesOutput = struct {
    /// A complex type that contains general information about the hosted zone.
    hosted_zones: ?[]const HostedZone = null,

    /// A flag indicating whether there are more hosted zones to be listed. If the
    /// response
    /// was truncated, you can get more hosted zones by submitting another
    /// `ListHostedZones` request and specifying the value of
    /// `NextMarker` in the `marker` parameter.
    is_truncated: ?bool = null,

    /// For the second and subsequent calls to `ListHostedZones`,
    /// `Marker` is the value that you specified for the `marker`
    /// parameter in the request that produced the current response.
    marker: []const u8,

    /// The value that you specified for the `maxitems` parameter in the call to
    /// `ListHostedZones` that produced the current response.
    max_items: i32,

    /// If `IsTruncated` is `true`, the value of `NextMarker`
    /// identifies the first hosted zone in the next group of hosted zones. Submit
    /// another
    /// `ListHostedZones` request, and specify the value of
    /// `NextMarker` from the response in the `marker`
    /// parameter.
    ///
    /// This element is present only if `IsTruncated` is `true`.
    next_marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListHostedZonesInput, options: CallOptions) !ListHostedZonesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListHostedZonesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/hostedzone";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.delegation_set_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "delegationsetid=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.hosted_zone_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "hostedzonetype=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "marker=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListHostedZonesOutput {
    var result: ListHostedZonesOutput = undefined;
    result.next_marker = null;
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
                if (std.mem.eql(u8, e.local, "HostedZones")) {
                    result.hosted_zones = try serde.deserializeHostedZones(allocator, &reader, "HostedZone");
                } else if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxItems")) {
                    result.max_items = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "NextMarker")) {
                    result.next_marker = try allocator.dupe(u8, try reader.readElementText());
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
