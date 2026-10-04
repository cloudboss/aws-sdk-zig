const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProfileDetail = @import("profile_detail.zig").ProfileDetail;

pub const UpdateProfileInput = struct {
    /// Used to determine if a custom role session name will be accepted in a
    /// temporary credential request.
    accept_role_session_name: ?bool = null,

    /// Used to determine how long sessions vended using this profile are valid for.
    /// See the `Expiration` section of the [CreateSession API
    /// documentation](https://docs.aws.amazon.com/rolesanywhere/latest/userguide/authentication-create-session.html#credentials-object) page for more details. In requests, if this value is not provided, the default value will be 3600.
    duration_seconds: ?i32 = null,

    /// A list of managed policy ARNs that apply to the vended session credentials.
    managed_policy_arns: ?[]const []const u8 = null,

    /// The name of the profile.
    name: ?[]const u8 = null,

    /// The unique identifier of the profile.
    profile_id: []const u8,

    /// A list of IAM roles that this profile can assume in a temporary credential
    /// request.
    role_arns: ?[]const []const u8 = null,

    /// A session policy that applies to the trust boundary of the vended session
    /// credentials.
    session_policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .accept_role_session_name = "acceptRoleSessionName",
        .duration_seconds = "durationSeconds",
        .managed_policy_arns = "managedPolicyArns",
        .name = "name",
        .profile_id = "profileId",
        .role_arns = "roleArns",
        .session_policy = "sessionPolicy",
    };
};

pub const UpdateProfileOutput = struct {
    /// The state of the profile after a read or write operation.
    profile: ?ProfileDetail = null,

    pub const json_field_names = .{
        .profile = "profile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProfileInput, options: CallOptions) !UpdateProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rolesanywhere", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rolesanywhere", "RolesAnywhere", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/profile/");
    try path_buf.appendSlice(allocator, input.profile_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.accept_role_session_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"acceptRoleSessionName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.duration_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"durationSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.managed_policy_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"managedPolicyArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionPolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProfileOutput {
    var result: UpdateProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
