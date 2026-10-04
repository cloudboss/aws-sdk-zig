const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthScope = @import("auth_scope.zig").AuthScope;
const AuthCodeEntityType = @import("auth_code_entity_type.zig").AuthCodeEntityType;

pub const CreateAuthCodeInput = struct {
    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The maximum duration of the session, in minutes. Minimum value of 1440 (24
    /// hours). Maximum value of 43200 (30
    /// days). If no value is provided, the session will expire after 400 days.
    max_session_duration_minutes: ?i32 = null,

    /// The scope for the authorization code. Defines the permissions and access
    /// boundaries for the session.
    scope: AuthScope,

    /// The duration of inactivity, in minutes, after which the session expires.
    /// Minimum value of 1440 (24 hours).
    /// Maximum value of 20160 (14 days).
    session_inactivity_duration_minutes: ?i32 = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .max_session_duration_minutes = "MaxSessionDurationMinutes",
        .scope = "Scope",
        .session_inactivity_duration_minutes = "SessionInactivityDurationMinutes",
    };
};

pub const CreateAuthCodeOutput = struct {
    /// The authorization code to use for establishing a session.
    auth_code: ?[]const u8 = null,

    /// The identifier of the entity associated with the authorization code.
    entity_id: ?[]const u8 = null,

    /// The type of entity associated with the authorization code.
    entity_type: ?AuthCodeEntityType = null,

    /// The identifier of the session created with the authorization code.
    session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_code = "AuthCode",
        .entity_id = "EntityId",
        .entity_type = "EntityType",
        .session_id = "SessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAuthCodeInput, options: CallOptions) !CreateAuthCodeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAuthCodeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/auth/code/");
    try path_buf.appendSlice(allocator, input.instance_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_session_duration_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxSessionDurationMinutes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Scope\":");
    try aws.json.writeValue(@TypeOf(input.scope), input.scope, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SessionInactivityDurationMinutes\":");
    try aws.json.writeValue(@TypeOf(input.session_inactivity_duration_minutes), input.session_inactivity_duration_minutes, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAuthCodeOutput {
    const result: CreateAuthCodeOutput = try aws.json.parseJsonObject(
        CreateAuthCodeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
