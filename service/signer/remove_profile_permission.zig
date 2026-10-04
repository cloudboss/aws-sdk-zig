const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RemoveProfilePermissionInput = struct {
    /// A human-readable name for the signing profile with permissions to be
    /// removed.
    profile_name: []const u8,

    /// An identifier for the current revision of the signing profile permissions.
    revision_id: []const u8,

    /// A unique identifier for the cross-account permissions statement.
    statement_id: []const u8,

    pub const json_field_names = .{
        .profile_name = "profileName",
        .revision_id = "revisionId",
        .statement_id = "statementId",
    };
};

pub const RemoveProfilePermissionOutput = struct {
    /// An identifier for the current revision of the profile permissions.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .revision_id = "revisionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RemoveProfilePermissionInput, options: CallOptions) !RemoveProfilePermissionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RemoveProfilePermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signer", "signer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/signing-profiles/");
    try path_buf.appendSlice(allocator, input.profile_name);
    try path_buf.appendSlice(allocator, "/permissions/");
    try path_buf.appendSlice(allocator, input.statement_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "revisionId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.revision_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RemoveProfilePermissionOutput {
    const result: RemoveProfilePermissionOutput = try aws.json.parseJsonObject(
        RemoveProfilePermissionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
