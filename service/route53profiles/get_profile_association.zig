const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProfileAssociation = @import("profile_association.zig").ProfileAssociation;

pub const GetProfileAssociationInput = struct {
    /// The identifier of the association you want to get information about.
    profile_association_id: []const u8,

    pub const json_field_names = .{
        .profile_association_id = "ProfileAssociationId",
    };
};

pub const GetProfileAssociationOutput = struct {
    /// Information about the Profile association that you specified in a
    /// `GetProfileAssociation` request.
    profile_association: ?ProfileAssociation = null,

    pub const json_field_names = .{
        .profile_association = "ProfileAssociation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProfileAssociationInput, options: CallOptions) !GetProfileAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53profiles", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProfileAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53profiles", "Route53Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/profileassociation/");
    try path_buf.appendSlice(allocator, input.profile_association_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProfileAssociationOutput {
    var result: GetProfileAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetProfileAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
