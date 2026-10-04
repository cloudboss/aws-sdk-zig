const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Profile = @import("profile.zig").Profile;

pub const DeleteProfileInput = struct {
    /// The ID of the Profile that you want to delete.
    profile_id: []const u8,

    pub const json_field_names = .{
        .profile_id = "ProfileId",
    };
};

pub const DeleteProfileOutput = struct {
    /// Information about the `DeleteProfile` request, including the status of the
    /// request.
    profile: ?Profile = null,

    pub const json_field_names = .{
        .profile = "Profile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteProfileInput, options: CallOptions) !DeleteProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53profiles", "Route53Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/profile/");
    try path_buf.appendSlice(allocator, input.profile_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteProfileOutput {
    const result: DeleteProfileOutput = try aws.json.parseJsonObject(
        DeleteProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
