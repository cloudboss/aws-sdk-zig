const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DelegationSet = @import("delegation_set.zig").DelegationSet;
const serde = @import("serde.zig");

pub const CreateReusableDelegationSetInput = struct {
    /// A unique string that identifies the request, and that allows you to retry
    /// failed
    /// `CreateReusableDelegationSet` requests without the risk of executing the
    /// operation twice. You must use a unique `CallerReference` string every time
    /// you submit a `CreateReusableDelegationSet` request.
    /// `CallerReference` can be any unique string, for example a date/time
    /// stamp.
    caller_reference: []const u8,

    /// If you want to mark the delegation set for an existing hosted zone as
    /// reusable, the ID
    /// for that hosted zone.
    hosted_zone_id: ?[]const u8 = null,
};

pub const CreateReusableDelegationSetOutput = struct {
    /// A complex type that contains name server information.
    delegation_set: ?DelegationSet = null,

    /// The unique URL representing the new reusable delegation set.
    location: []const u8,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReusableDelegationSetInput, options: CallOptions) !CreateReusableDelegationSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReusableDelegationSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-04-01/delegationset";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateReusableDelegationSetRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    try body_buf.appendSlice(allocator, "<CallerReference>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.caller_reference);
    try body_buf.appendSlice(allocator, "</CallerReference>");
    if (input.hosted_zone_id) |v| {
        try body_buf.appendSlice(allocator, "<HostedZoneId>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</HostedZoneId>");
    }
    try body_buf.appendSlice(allocator, "</CreateReusableDelegationSetRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReusableDelegationSetOutput {
    var result: CreateReusableDelegationSetOutput = undefined;
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
                if (std.mem.eql(u8, e.local, "DelegationSet")) {
                    result.delegation_set = try serde.deserializeDelegationSet(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

    return result;
}
