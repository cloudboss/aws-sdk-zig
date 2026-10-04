const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VPC = @import("vpc.zig").VPC;
const ChangeInfo = @import("change_info.zig").ChangeInfo;
const serde = @import("serde.zig");

pub const AssociateVPCWithHostedZoneInput = struct {
    /// *Optional:* A comment about the association request.
    comment: ?[]const u8 = null,

    /// The ID of the private hosted zone that you want to associate an Amazon VPC
    /// with.
    ///
    /// Note that you can't associate a VPC with a hosted zone that doesn't have an
    /// existing
    /// VPC association.
    hosted_zone_id: []const u8,

    /// A complex type that contains information about the VPC that you want to
    /// associate with
    /// a private hosted zone.
    vpc: VPC,
};

pub const AssociateVPCWithHostedZoneOutput = struct {
    /// A complex type that describes the changes made to your hosted zone.
    change_info: ?ChangeInfo = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateVPCWithHostedZoneInput, options: CallOptions) !AssociateVPCWithHostedZoneOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateVPCWithHostedZoneInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/hostedzone/");
    try path_buf.appendSlice(allocator, input.hosted_zone_id);
    try path_buf.appendSlice(allocator, "/associatevpc");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<AssociateVPCWithHostedZoneRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    if (input.comment) |v| {
        try body_buf.appendSlice(allocator, "<Comment>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Comment>");
    }
    try body_buf.appendSlice(allocator, "<VPC>");
    try serde.serializeVPC(allocator, &body_buf, input.vpc);
    try body_buf.appendSlice(allocator, "</VPC>");
    try body_buf.appendSlice(allocator, "</AssociateVPCWithHostedZoneRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateVPCWithHostedZoneOutput {
    var result: AssociateVPCWithHostedZoneOutput = undefined;
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
                if (std.mem.eql(u8, e.local, "ChangeInfo")) {
                    result.change_info = try serde.deserializeChangeInfo(allocator, &reader);
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
