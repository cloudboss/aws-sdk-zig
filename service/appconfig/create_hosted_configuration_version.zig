const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const CreateHostedConfigurationVersionInput = struct {
    /// The application ID.
    application_id: []const u8,

    /// The configuration profile ID.
    configuration_profile_id: []const u8,

    /// The configuration data, as bytes.
    ///
    /// AppConfig accepts any type of data, including text formats like JSON or
    /// TOML, or binary formats like protocol buffers or compressed data.
    content: []const u8,

    /// A standard MIME type describing the format of the configuration content. For
    /// more
    /// information, see
    /// [Content-Type](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.17).
    content_type: []const u8,

    /// A description of the configuration.
    description: ?[]const u8 = null,

    /// An optional locking token used to prevent race conditions from overwriting
    /// configuration
    /// updates when creating a new version. To ensure your data is not overwritten
    /// when creating
    /// multiple hosted configuration versions in rapid succession, specify the
    /// version number of
    /// the latest hosted configuration version.
    latest_version_number: ?i32 = null,

    /// An optional, user-defined label for the AppConfig hosted configuration
    /// version. This value must contain at least one non-numeric character. For
    /// example,
    /// "v2.2.0".
    version_label: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .configuration_profile_id = "ConfigurationProfileId",
        .content = "Content",
        .content_type = "ContentType",
        .description = "Description",
        .latest_version_number = "LatestVersionNumber",
        .version_label = "VersionLabel",
    };
};

pub const CreateHostedConfigurationVersionOutput = struct {
    /// The application ID.
    application_id: ?[]const u8 = null,

    /// The configuration profile ID.
    configuration_profile_id: ?[]const u8 = null,

    /// The content of the configuration or the configuration data.
    content: ?[]const u8 = null,

    /// A standard MIME type describing the format of the configuration content. For
    /// more
    /// information, see
    /// [Content-Type](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.17).
    content_type: ?[]const u8 = null,

    /// A description of the configuration.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name of the Key Management Service key that was used to
    /// encrypt this
    /// specific version of the configuration data in the AppConfig hosted
    /// configuration
    /// store.
    kms_key_arn: ?[]const u8 = null,

    /// A user-defined label for an AppConfig hosted configuration version.
    version_label: ?[]const u8 = null,

    /// The configuration version.
    version_number: ?i32 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .configuration_profile_id = "ConfigurationProfileId",
        .content = "Content",
        .content_type = "ContentType",
        .description = "Description",
        .kms_key_arn = "KmsKeyArn",
        .version_label = "VersionLabel",
        .version_number = "VersionNumber",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHostedConfigurationVersionInput, options: Options) !CreateHostedConfigurationVersionOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateHostedConfigurationVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/applications/");
    try path_buf.appendSlice(alloc, input.application_id);
    try path_buf.appendSlice(alloc, "/configurationprofiles/");
    try path_buf.appendSlice(alloc, input.configuration_profile_id);
    try path_buf.appendSlice(alloc, "/hostedconfigurationversions");
    const path = try path_buf.toOwnedSlice(alloc);

    const body = input.content;

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");
    try request.headers.put(alloc, "Content-Type", input.content_type);
    if (input.description) |v| {
        try request.headers.put(alloc, "Description", v);
    }
    if (input.latest_version_number) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "Latest-Version-Number", num_str);
        }
    }
    if (input.version_label) |v| {
        try request.headers.put(alloc, "VersionLabel", v);
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateHostedConfigurationVersionOutput {
    var result: CreateHostedConfigurationVersionOutput = .{};
    if (body.len > 0) {
        result.content = try alloc.dupe(u8, body);
    }
    _ = status;
    if (headers.get("application-id")) |value| {
        result.application_id = try alloc.dupe(u8, value);
    }
    if (headers.get("configuration-profile-id")) |value| {
        result.configuration_profile_id = try alloc.dupe(u8, value);
    }
    if (headers.get("content-type")) |value| {
        result.content_type = try alloc.dupe(u8, value);
    }
    if (headers.get("description")) |value| {
        result.description = try alloc.dupe(u8, value);
    }
    if (headers.get("kmskeyarn")) |value| {
        result.kms_key_arn = try alloc.dupe(u8, value);
    }
    if (headers.get("versionlabel")) |value| {
        result.version_label = try alloc.dupe(u8, value);
    }
    if (headers.get("version-number")) |value| {
        result.version_number = std.fmt.parseInt(i32, value, 10) catch null;
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
