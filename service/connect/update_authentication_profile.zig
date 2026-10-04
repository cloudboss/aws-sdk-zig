const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateAuthenticationProfileInput = struct {
    /// A list of IP address range strings that are allowed to access the instance.
    /// For more information on how to
    /// configure IP addresses, see[Configure session
    /// timeouts](https://docs.aws.amazon.com/connect/latest/adminguide/authentication-profiles.html#configure-session-timeouts) in the *Connect Customer Administrator Guide*.
    allowed_ips: ?[]const []const u8 = null,

    /// A unique identifier for the authentication profile.
    authentication_profile_id: []const u8,

    /// A list of IP address range strings that are blocked from accessing the
    /// instance. For more information on how to
    /// configure IP addresses, For more information on how to configure IP
    /// addresses, see [Configure IP-based access
    /// control](https://docs.aws.amazon.com/connect/latest/adminguide/authentication-profiles.html#configure-ip-based-ac) in the *Connect Customer Administrator Guide*.
    blocked_ips: ?[]const []const u8 = null,

    /// The description for the authentication profile.
    description: ?[]const u8 = null,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The name for the authentication profile.
    name: ?[]const u8 = null,

    /// The short lived session duration configuration for users logged in to
    /// Connect Customer, in minutes. This value
    /// determines the maximum possible time before an agent is authenticated. For
    /// more information, For more information on
    /// how to configure IP addresses, see [Configure session
    /// timeouts](https://docs.aws.amazon.com/connect/latest/adminguide/authentication-profiles.html#configure-session-timeouts) in the *Connect Customer Administrator Guide*.
    periodic_session_duration: ?i32 = null,

    /// The period, in minutes, before an agent is automatically signed out of the
    /// contact center when they go
    /// inactive.
    session_inactivity_duration: ?i32 = null,

    /// Determines if automatic logout on user inactivity is enabled.
    session_inactivity_handling_enabled: ?bool = null,

    pub const json_field_names = .{
        .allowed_ips = "AllowedIps",
        .authentication_profile_id = "AuthenticationProfileId",
        .blocked_ips = "BlockedIps",
        .description = "Description",
        .instance_id = "InstanceId",
        .name = "Name",
        .periodic_session_duration = "PeriodicSessionDuration",
        .session_inactivity_duration = "SessionInactivityDuration",
        .session_inactivity_handling_enabled = "SessionInactivityHandlingEnabled",
    };
};

pub const UpdateAuthenticationProfileOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAuthenticationProfileInput, options: CallOptions) !UpdateAuthenticationProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAuthenticationProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/authentication-profiles/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.authentication_profile_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allowed_ips) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AllowedIps\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.blocked_ips) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BlockedIps\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.periodic_session_duration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PeriodicSessionDuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_inactivity_duration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SessionInactivityDuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_inactivity_handling_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SessionInactivityHandlingEnabled\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAuthenticationProfileOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateAuthenticationProfileOutput = .{};

    return result;
}
