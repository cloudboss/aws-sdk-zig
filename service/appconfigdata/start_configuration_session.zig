const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const StartConfigurationSessionInput = struct {
    /// The application ID or the application name.
    application_identifier: []const u8,

    /// The configuration profile ID or the configuration profile name.
    configuration_profile_identifier: []const u8,

    /// The environment ID or the environment name.
    environment_identifier: []const u8,

    /// Sets a constraint on a session. If you specify a value of, for example, 60
    /// seconds, then
    /// the client that established the session can't call GetLatestConfiguration
    /// more frequently than every 60 seconds.
    required_minimum_poll_interval_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .application_identifier = "ApplicationIdentifier",
        .configuration_profile_identifier = "ConfigurationProfileIdentifier",
        .environment_identifier = "EnvironmentIdentifier",
        .required_minimum_poll_interval_in_seconds = "RequiredMinimumPollIntervalInSeconds",
    };
};

pub const StartConfigurationSessionOutput = struct {
    /// Token encapsulating state about the configuration session. Provide this
    /// token to the
    /// `GetLatestConfiguration` API to retrieve configuration data.
    ///
    /// This token should only be used once in your first call to
    /// `GetLatestConfiguration`. You *must* use the new token
    /// in the `GetLatestConfiguration` response
    /// (`NextPollConfigurationToken`) in each subsequent call to
    /// `GetLatestConfiguration`.
    ///
    /// The `InitialConfigurationToken` and
    /// `NextPollConfigurationToken` should only be used once. To support long poll
    /// use cases, the tokens are valid for up to 24 hours. If a
    /// `GetLatestConfiguration` call uses an expired token, the system returns
    /// `BadRequestException`.
    initial_configuration_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .initial_configuration_token = "InitialConfigurationToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartConfigurationSessionInput, options: CallOptions) !StartConfigurationSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appconfigdata");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: StartConfigurationSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfigdata", "AppConfigData", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/configurationsessions";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ApplicationIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.application_identifier), input.application_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConfigurationProfileIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.configuration_profile_identifier), input.configuration_profile_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EnvironmentIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.environment_identifier), input.environment_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.required_minimum_poll_interval_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequiredMinimumPollIntervalInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartConfigurationSessionOutput {
    var result: StartConfigurationSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartConfigurationSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
