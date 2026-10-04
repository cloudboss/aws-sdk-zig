const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserProfileStatus = @import("user_profile_status.zig").UserProfileStatus;
const UserProfileType = @import("user_profile_type.zig").UserProfileType;
const UserProfileDetails = @import("user_profile_details.zig").UserProfileDetails;

pub const UpdateUserProfileInput = struct {
    /// The identifier of the Amazon DataZone domain in which a user profile is
    /// updated.
    domain_identifier: []const u8,

    /// The session name for IAM role sessions.
    session_name: ?[]const u8 = null,

    /// The status of the user profile that are to be updated.
    status: UserProfileStatus,

    /// The type of the user profile that are to be updated.
    @"type": ?UserProfileType = null,

    /// The identifier of the user whose user profile is to be updated.
    user_identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .session_name = "sessionName",
        .status = "status",
        .@"type" = "type",
        .user_identifier = "userIdentifier",
    };
};

pub const UpdateUserProfileOutput = struct {
    /// The results of the UpdateUserProfile action.
    details: ?UserProfileDetails = null,

    /// The identifier of the Amazon DataZone domain in which a user profile is
    /// updated.
    domain_id: ?[]const u8 = null,

    /// The identifier of the user profile.
    id: ?[]const u8 = null,

    /// The status of the user profile.
    status: ?UserProfileStatus = null,

    /// The type of the user profile.
    @"type": ?UserProfileType = null,

    pub const json_field_names = .{
        .details = "details",
        .domain_id = "domainId",
        .id = "id",
        .status = "status",
        .@"type" = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateUserProfileInput, options: CallOptions) !UpdateUserProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateUserProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/user-profiles/");
    try path_buf.appendSlice(allocator, input.user_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.session_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"status\":");
    try aws.json.writeValue(@TypeOf(input.status), input.status, allocator, &body_buf);
    has_prev = true;
    if (input.@"type") |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"type\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateUserProfileOutput {
    var result: UpdateUserProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateUserProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
