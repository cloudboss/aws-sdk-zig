const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ColorScheme = @import("color_scheme.zig").ColorScheme;
const MapStyle = @import("map_style.zig").MapStyle;
const Variant = @import("variant.zig").Variant;

pub const GetSpritesInput = struct {
    /// Sets color tone for map such as dark and light for specific map styles. It
    /// applies to only vector map styles such as Standard and Monochrome.
    ///
    /// Example: `Light`
    ///
    /// Default value: `Light`
    ///
    /// Valid values for ColorScheme are case sensitive.
    color_scheme: ColorScheme,

    /// `Sprites` API: The name of the sprite ﬁle to retrieve, following pattern
    /// `sprites(@2x)?\.(png|json)`.
    ///
    /// Example: `sprites.png`
    file_name: []const u8,

    /// Style specifies the desired map style for the `Sprites` APIs.
    style: MapStyle,

    /// Optimizes map styles for specific use case or industry. You can choose
    /// allowed variant only with Standard map style.
    ///
    /// Example: `Default`
    ///
    /// Valid values for Variant are case sensitive.
    variant: Variant,

    pub const json_field_names = .{
        .color_scheme = "ColorScheme",
        .file_name = "FileName",
        .style = "Style",
        .variant = "Variant",
    };
};

pub const GetSpritesOutput = struct {
    /// The body of the sprite sheet or JSON offset file (image/png or
    /// application/json, depending on input).
    blob: ?[]const u8 = null,

    /// Header that instructs caching configuration for the client.
    cache_control: ?[]const u8 = null,

    /// Header that represents the format of the response. The response returns the
    /// following as the HTTP body.
    content_type: ?[]const u8 = null,

    /// The sprite's Etag.
    e_tag: ?[]const u8 = null,

    pub const json_field_names = .{
        .blob = "Blob",
        .cache_control = "CacheControl",
        .content_type = "ContentType",
        .e_tag = "ETag",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSpritesInput, options: CallOptions) !GetSpritesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "geomaps");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSpritesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geomaps", "Geo Maps", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/styles/");
    try path_buf.appendSlice(allocator, input.style);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.color_scheme);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.variant);
    try path_buf.appendSlice(allocator, "/sprites/");
    try path_buf.appendSlice(allocator, input.file_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSpritesOutput {
    var result: GetSpritesOutput = .{};
    if (body.len > 0) {
        result.blob = try allocator.dupe(u8, body);
    }
    _ = status;
    if (headers.get("cache-control")) |value| {
        result.cache_control = try allocator.dupe(u8, value);
    }
    if (headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
