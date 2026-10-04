const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VPC = @import("vpc.zig").VPC;
const serde = @import("serde.zig");

pub const DeleteVPCAssociationAuthorizationInput = struct {
    /// When removing authorization to associate a VPC that was created by one
    /// Amazon Web Services account with a hosted zone that was created with a
    /// different Amazon Web Services account, the ID of the hosted zone.
    hosted_zone_id: []const u8,

    /// When removing authorization to associate a VPC that was created by one
    /// Amazon Web Services account with a hosted zone that was created with a
    /// different Amazon Web Services account, a complex type that includes the ID
    /// and region of the
    /// VPC.
    vpc: VPC,
};

pub const DeleteVPCAssociationAuthorizationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteVPCAssociationAuthorizationInput, options: CallOptions) !DeleteVPCAssociationAuthorizationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteVPCAssociationAuthorizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53", "Route 53", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2013-04-01/hostedzone/");
    try path_buf.appendSlice(allocator, input.hosted_zone_id);
    try path_buf.appendSlice(allocator, "/deauthorizevpcassociation");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<DeleteVPCAssociationAuthorizationRequest xmlns=\"https://route53.amazonaws.com/doc/2013-04-01/\">");
    try body_buf.appendSlice(allocator, "<VPC>");
    try serde.serializeVPC(allocator, &body_buf, input.vpc);
    try body_buf.appendSlice(allocator, "</VPC>");
    try body_buf.appendSlice(allocator, "</DeleteVPCAssociationAuthorizationRequest>");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteVPCAssociationAuthorizationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteVPCAssociationAuthorizationOutput = .{};

    return result;
}
