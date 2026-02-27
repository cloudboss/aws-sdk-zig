const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const GetLatestConfigurationInput = struct {
    /// Token describing the current state of the configuration session. To obtain a
    /// token,
    /// first call the StartConfigurationSession API. Note that every call to
    /// `GetLatestConfiguration` will return a new `ConfigurationToken`
    /// (`NextPollConfigurationToken` in the response) and *must*
    /// be provided to subsequent `GetLatestConfiguration` API calls.
    ///
    /// This token should only be used once. To support long poll
    /// use cases, the token is valid for up to 24 hours. If a
    /// `GetLatestConfiguration` call uses an expired token, the system returns
    /// `BadRequestException`.
    configuration_token: []const u8,

    pub const json_field_names = .{
        .configuration_token = "ConfigurationToken",
    };
};

pub const GetLatestConfigurationOutput = struct {
    /// The data of the configuration. This may be empty if the client already has
    /// the latest
    /// version of configuration.
    configuration: ?[]const u8 = null,

    /// A standard MIME type describing the format of the configuration content.
    content_type: ?[]const u8 = null,

    /// The latest token describing the current state of the configuration session.
    /// This
    /// *must* be provided to the next call to
    /// `GetLatestConfiguration.`
    ///
    /// This token should only be used once. To support long poll
    /// use cases, the token is valid for up to 24 hours. If a
    /// `GetLatestConfiguration` call uses an expired token, the system returns
    /// `BadRequestException`.
    next_poll_configuration_token: ?[]const u8 = null,

    /// The amount of time the client should wait before polling for configuration
    /// updates
    /// again. Use `RequiredMinimumPollIntervalInSeconds` to set the desired poll
    /// interval.
    next_poll_interval_in_seconds: i32 = 0,

    /// The user-defined label for the AppConfig hosted configuration version. This
    /// attribute doesn't apply if the configuration is not from an AppConfig hosted
    /// configuration version. If the client already has the latest version of the
    /// configuration data, this value is empty.
    version_label: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .content_type = "ContentType",
        .next_poll_configuration_token = "NextPollConfigurationToken",
        .next_poll_interval_in_seconds = "NextPollIntervalInSeconds",
        .version_label = "VersionLabel",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLatestConfigurationInput, options: Options) !GetLatestConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appconfigdata");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetLatestConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfigdata", "AppConfigData", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/configuration";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "configuration_token=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.configuration_token);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetLatestConfigurationOutput {
    var result: GetLatestConfigurationOutput = .{};
    if (body.len > 0) {
        result.configuration = try alloc.dupe(u8, body);
    }
    _ = status;
    if (headers.get("content-type")) |value| {
        result.content_type = try alloc.dupe(u8, value);
    }
    if (headers.get("next-poll-configuration-token")) |value| {
        result.next_poll_configuration_token = try alloc.dupe(u8, value);
    }
    if (headers.get("next-poll-interval-in-seconds")) |value| {
        result.next_poll_interval_in_seconds = std.fmt.parseInt(i32, value, 10) catch null;
    }
    if (headers.get("version-label")) |value| {
        result.version_label = try alloc.dupe(u8, value);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
