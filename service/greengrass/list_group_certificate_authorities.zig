const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupCertificateAuthorityProperties = @import("group_certificate_authority_properties.zig").GroupCertificateAuthorityProperties;

pub const ListGroupCertificateAuthoritiesInput = struct {
    /// The ID of the Greengrass group.
    group_id: []const u8,

    pub const json_field_names = .{
        .group_id = "GroupId",
    };
};

pub const ListGroupCertificateAuthoritiesOutput = struct {
    /// A list of certificate authorities associated with the group.
    group_certificate_authorities: ?[]const GroupCertificateAuthorityProperties = null,

    pub const json_field_names = .{
        .group_certificate_authorities = "GroupCertificateAuthorities",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGroupCertificateAuthoritiesInput, options: CallOptions) !ListGroupCertificateAuthoritiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListGroupCertificateAuthoritiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "Greengrass", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/greengrass/groups/");
    try path_buf.appendSlice(allocator, input.group_id);
    try path_buf.appendSlice(allocator, "/certificateauthorities");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListGroupCertificateAuthoritiesOutput {
    const result: ListGroupCertificateAuthoritiesOutput = try aws.json.parseJsonObject(
        ListGroupCertificateAuthoritiesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
