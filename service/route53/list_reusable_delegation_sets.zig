const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DelegationSet = @import("delegation_set.zig").DelegationSet;
const serde = @import("serde.zig");

pub const ListReusableDelegationSetsInput = struct {
    /// If the value of `IsTruncated` in the previous response was
    /// `true`, you have more reusable delegation sets. To get another group,
    /// submit another `ListReusableDelegationSets` request.
    ///
    /// For the value of `marker`, specify the value of `NextMarker`
    /// from the previous response, which is the ID of the first reusable delegation
    /// set that
    /// Amazon Route 53 will return if you submit another request.
    ///
    /// If the value of `IsTruncated` in the previous response was
    /// `false`, there are no more reusable delegation sets to get.
    marker: ?[]const u8 = null,

    /// The number of reusable delegation sets that you want Amazon Route 53 to
    /// return in the
    /// response to this request. If you specify a value greater than 100, Route 53
    /// returns only
    /// the first 100 reusable delegation sets.
    max_items: ?i32 = null,
};

pub const ListReusableDelegationSetsOutput = struct {
    /// A complex type that contains one `DelegationSet` element for each reusable
    /// delegation set that was created by the current Amazon Web Services account.
    delegation_sets: ?[]const DelegationSet = null,

    /// A flag that indicates whether there are more reusable delegation sets to be
    /// listed.
    is_truncated: ?bool = null,

    /// For the second and subsequent calls to `ListReusableDelegationSets`,
    /// `Marker` is the value that you specified for the `marker`
    /// parameter in the request that produced the current response.
    marker: []const u8,

    /// The value that you specified for the `maxitems` parameter in the call to
    /// `ListReusableDelegationSets` that produced the current response.
    max_items: i32,

    /// If `IsTruncated` is `true`, the value of `NextMarker`
    /// identifies the next reusable delegation set that Amazon Route 53 will return
    /// if you
    /// submit another `ListReusableDelegationSets` request and specify the value of
    /// `NextMarker` in the `marker` parameter.
    next_marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListReusableDelegationSetsInput, options: CallOptions) !ListReusableDelegationSetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListReusableDelegationSetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/delegationset";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListReusableDelegationSetsOutput {
    var result: ListReusableDelegationSetsOutput = undefined;
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
                if (std.mem.eql(u8, e.local, "DelegationSets")) {
                    result.delegation_sets = try serde.deserializeDelegationSets(allocator, &reader, "DelegationSet");
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
