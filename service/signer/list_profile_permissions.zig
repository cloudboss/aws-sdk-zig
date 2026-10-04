const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Permission = @import("permission.zig").Permission;

pub const ListProfilePermissionsInput = struct {
    /// String for specifying the next set of paginated results.
    next_token: ?[]const u8 = null,

    /// Name of the signing profile containing the cross-account permissions.
    profile_name: []const u8,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .profile_name = "profileName",
    };
};

pub const ListProfilePermissionsOutput = struct {
    /// String for specifying the next set of paginated results.
    next_token: ?[]const u8 = null,

    /// List of permissions associated with the Signing Profile.
    permissions: ?[]const Permission = null,

    /// Total size of the policy associated with the Signing Profile in bytes.
    policy_size_bytes: ?i32 = null,

    /// The identifier for the current revision of profile permissions.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .permissions = "permissions",
        .policy_size_bytes = "policySizeBytes",
        .revision_id = "revisionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProfilePermissionsInput, options: CallOptions) !ListProfilePermissionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "signer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProfilePermissionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signer", "signer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/signing-profiles/");
    try path_buf.appendSlice(allocator, input.profile_name);
    try path_buf.appendSlice(allocator, "/permissions");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProfilePermissionsOutput {
    const result: ListProfilePermissionsOutput = try aws.json.parseJsonObject(
        ListProfilePermissionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
