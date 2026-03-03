const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const GetConfigurationInput = struct {
    /// The application to get. Specify either the application name or the
    /// application
    /// ID.
    application: []const u8,

    /// The configuration version returned in the most recent GetConfiguration
    /// response.
    ///
    /// AppConfig uses the value of the `ClientConfigurationVersion`
    /// parameter to identify the configuration version on your clients. If you
    /// don’t send
    /// `ClientConfigurationVersion` with each call to GetConfiguration, your
    /// clients receive the current configuration. You are
    /// charged each time your clients receive a configuration.
    ///
    /// To avoid excess charges, we recommend you use the
    /// [StartConfigurationSession](https://docs.aws.amazon.com/appconfig/2019-10-09/APIReference/StartConfigurationSession.html) and [GetLatestConfiguration](https://docs.aws.amazon.com/appconfig/2019-10-09/APIReference/GetLatestConfiguration.html) APIs, which track the client configuration version on
    /// your behalf. If you choose to continue using GetConfiguration, we
    /// recommend that you include the `ClientConfigurationVersion` value with every
    /// call to GetConfiguration. The value to use for
    /// `ClientConfigurationVersion` comes from the
    /// `ConfigurationVersion` attribute returned by GetConfiguration when there is
    /// new or updated data, and should be saved
    /// for subsequent calls to GetConfiguration.
    ///
    /// For more information about working with configurations, see [Retrieving
    /// feature flags and
    /// configuration data in
    /// AppConfig](http://docs.aws.amazon.com/appconfig/latest/userguide/retrieving-feature-flags.html) in the *AppConfig
    /// User Guide*.
    client_configuration_version: ?[]const u8 = null,

    /// The clientId parameter in the following command is a unique, user-specified
    /// ID to
    /// identify the client for the configuration. This ID enables AppConfig to
    /// deploy
    /// the configuration in intervals, as defined in the deployment strategy.
    client_id: []const u8,

    /// The configuration to get. Specify either the configuration name or the
    /// configuration
    /// ID.
    configuration: []const u8,

    /// The environment to get. Specify either the environment name or the
    /// environment
    /// ID.
    environment: []const u8,

    pub const json_field_names = .{
        .application = "Application",
        .client_configuration_version = "ClientConfigurationVersion",
        .client_id = "ClientId",
        .configuration = "Configuration",
        .environment = "Environment",
    };
};

pub const GetConfigurationOutput = struct {
    /// The configuration version.
    configuration_version: ?[]const u8 = null,

    /// The content of the configuration or the configuration data.
    ///
    /// The `Content` attribute only contains data if the system finds new or
    /// updated configuration data. If there is no new or updated data and
    /// `ClientConfigurationVersion` matches the version of the current
    /// configuration, AppConfig returns a `204 No Content` HTTP response
    /// code and the `Content` value will be empty.
    content: ?[]const u8 = null,

    /// A standard MIME type describing the format of the configuration content. For
    /// more
    /// information, see
    /// [Content-Type](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.17).
    content_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_version = "ConfigurationVersion",
        .content = "Content",
        .content_type = "ContentType",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConfigurationInput, options: Options) !GetConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appconfig");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application);
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment);
    try path_buf.appendSlice(allocator, "/configurations/");
    try path_buf.appendSlice(allocator, input.configuration);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.client_configuration_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "client_configuration_version=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "client_id=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.client_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConfigurationOutput {
    var result: GetConfigurationOutput = .{};
    if (body.len > 0) {
        result.content = try allocator.dupe(u8, body);
    }
    _ = status;
    if (headers.get("configuration-version")) |value| {
        result.configuration_version = try allocator.dupe(u8, value);
    }
    if (headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }

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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "PayloadTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .payload_too_large_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
