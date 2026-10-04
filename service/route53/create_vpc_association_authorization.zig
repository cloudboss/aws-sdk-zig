const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VPC = @import("vpc.zig").VPC;
const serde = @import("serde.zig");

pub const CreateVPCAssociationAuthorizationInput = struct {
    /// The ID of the private hosted zone that you want to authorize associating a
    /// VPC
    /// with.
    hosted_zone_id: []const u8,

    /// A complex type that contains the VPC ID and region for the VPC that you want
    /// to
    /// authorize associating with your hosted zone.
    vpc: VPC,
};

pub const CreateVPCAssociationAuthorizationOutput = struct {
    /// The ID of the hosted zone that you authorized associating a VPC with.
    hosted_zone_id: []const u8,

    /// The VPC that you authorized associating with a hosted zone.
    vpc: ?VPC = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVPCAssociationAuthorizationInput, options: CallOptions) !CreateVPCAssociationAuthorizationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVPCAssociationAuthorizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/hostedzone/");
    try path_buf.appendSlice(allocator, input.hosted_zone_id);
    try path_buf.appendSlice(allocator, "/authorizevpcassociation");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateVPCAssociationAuthorizationRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    try body_buf.appendSlice(allocator, "<VPC>");
    try serde.serializeVPC(allocator, &body_buf, input.vpc);
    try body_buf.appendSlice(allocator, "</VPC>");
    try body_buf.appendSlice(allocator, "</CreateVPCAssociationAuthorizationRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVPCAssociationAuthorizationOutput {
    var result: CreateVPCAssociationAuthorizationOutput = undefined;
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
                } else if (std.mem.eql(u8, e.local, "VPC")) {
                    result.vpc = try serde.deserializeVPC(allocator, &reader);
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
