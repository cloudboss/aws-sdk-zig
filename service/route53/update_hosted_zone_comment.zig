const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HostedZone = @import("hosted_zone.zig").HostedZone;
const serde = @import("serde.zig");

pub const UpdateHostedZoneCommentInput = struct {
    /// The new comment for the hosted zone. If you don't specify a value for
    /// `Comment`, Amazon Route 53 deletes the existing value of the
    /// `Comment` element, if any.
    comment: ?[]const u8 = null,

    /// The ID for the hosted zone that you want to update the comment for.
    id: []const u8,
};

pub const UpdateHostedZoneCommentOutput = struct {
    /// A complex type that contains the response to the `UpdateHostedZoneComment`
    /// request.
    hosted_zone: ?HostedZone = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateHostedZoneCommentInput, options: CallOptions) !UpdateHostedZoneCommentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateHostedZoneCommentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/hostedzone/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<UpdateHostedZoneCommentRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    if (input.comment) |v| {
        try body_buf.appendSlice(allocator, "<Comment>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Comment>");
    }
    try body_buf.appendSlice(allocator, "</UpdateHostedZoneCommentRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateHostedZoneCommentOutput {
    var result: UpdateHostedZoneCommentOutput = undefined;
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
                if (std.mem.eql(u8, e.local, "HostedZone")) {
                    result.hosted_zone = try serde.deserializeHostedZone(allocator, &reader);
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
