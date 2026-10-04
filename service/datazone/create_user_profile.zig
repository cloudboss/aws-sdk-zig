const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserType = @import("user_type.zig").UserType;
const UserProfileDetails = @import("user_profile_details.zig").UserProfileDetails;
const UserProfileStatus = @import("user_profile_status.zig").UserProfileStatus;
const UserProfileType = @import("user_profile_type.zig").UserProfileType;

pub const CreateUserProfileInput = struct {
    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which a user profile is
    /// created.
    domain_identifier: []const u8,

    /// The session name for IAM role sessions.
    session_name: ?[]const u8 = null,

    /// The identifier of the user for which the user profile is created.
    user_identifier: []const u8,

    /// The user type of the user for which the user profile is created.
    user_type: ?UserType = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .domain_identifier = "domainIdentifier",
        .session_name = "sessionName",
        .user_identifier = "userIdentifier",
        .user_type = "userType",
    };
};

pub const CreateUserProfileOutput = struct {
    /// The user profile details.
    details: ?UserProfileDetails = null,

    /// The identifier of the Amazon DataZone domain in which a user profile is
    /// created.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUserProfileInput, options: CallOptions) !CreateUserProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateUserProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/user-profiles");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"userIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.user_identifier), input.user_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.user_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateUserProfileOutput {
    var result: CreateUserProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateUserProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
