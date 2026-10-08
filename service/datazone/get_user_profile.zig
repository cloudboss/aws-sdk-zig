const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserProfileType = @import("user_profile_type.zig").UserProfileType;
const UserProfileDetails = @import("user_profile_details.zig").UserProfileDetails;
const UserProfileStatus = @import("user_profile_status.zig").UserProfileStatus;

pub const GetUserProfileInput = struct {
    /// the ID of the Amazon DataZone domain the data portal of which you want to
    /// get.
    domain_identifier: []const u8,

    /// The session name for IAM role sessions.
    session_name: ?[]const u8 = null,

    /// The type of the user profile.
    type: ?UserProfileType = null,

    /// The identifier of the user for which you want to get the user profile.
    user_identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .session_name = "sessionName",
        .type = "type",
        .user_identifier = "userIdentifier",
    };
};

pub const GetUserProfileOutput = struct {
    /// The user profile details.
    details: ?UserProfileDetails = null,

    /// the identifier of the Amazon DataZone domain of which you want to get the
    /// user profile.
    domain_id: ?[]const u8 = null,

    /// The identifier of the user profile.
    id: ?[]const u8 = null,

    /// The status of the user profile.
    status: ?UserProfileStatus = null,

    /// The type of the user profile.
    type: ?UserProfileType = null,

    pub const json_field_names = .{
        .details = "details",
        .domain_id = "domainId",
        .id = "id",
        .status = "status",
        .type = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUserProfileInput, options: CallOptions) !GetUserProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUserProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/user-profiles/");
    try path_buf.appendSlice(allocator, input.user_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.session_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sessionName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "type=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUserProfileOutput {
    const result: GetUserProfileOutput = try aws.json.parseJsonObject(
        GetUserProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
