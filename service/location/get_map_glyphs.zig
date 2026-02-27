const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const GetMapGlyphsInput = struct {
    /// A comma-separated list of fonts to load glyphs from in order of preference.
    /// For example, `Noto Sans Regular, Arial Unicode`.
    ///
    /// Valid font stacks for
    /// [Esri](https://docs.aws.amazon.com/location/previous/developerguide/esri.html) styles:
    ///
    /// * VectorEsriDarkGrayCanvas – `Ubuntu Medium Italic` | `Ubuntu Medium` |
    ///   `Ubuntu Italic` | `Ubuntu Regular` | `Ubuntu Bold`
    /// * VectorEsriLightGrayCanvas – `Ubuntu Italic` | `Ubuntu Regular` | `Ubuntu
    ///   Light` | `Ubuntu Bold`
    /// * VectorEsriTopographic – `Noto Sans Italic` | `Noto Sans Regular` | `Noto
    ///   Sans Bold` | `Noto Serif Regular` | `Roboto Condensed Light Italic`
    /// * VectorEsriStreets – `Arial Regular` | `Arial Italic` | `Arial Bold`
    /// * VectorEsriNavigation – `Arial Regular` | `Arial Italic` | `Arial Bold`
    ///
    /// Valid font stacks for [HERE
    /// Technologies](https://docs.aws.amazon.com/location/previous/developerguide/HERE.html) styles:
    ///
    /// * VectorHereContrast – `Fira GO Regular` | `Fira GO Bold`
    /// * VectorHereExplore, VectorHereExploreTruck, HybridHereExploreSatellite –
    ///   `Fira GO Italic` | `Fira GO Map` | `Fira GO Map Bold` | `Noto Sans CJK JP
    ///   Bold` | `Noto Sans CJK JP Light` | `Noto Sans CJK JP Regular`
    ///
    /// Valid font stacks for
    /// [GrabMaps](https://docs.aws.amazon.com/location/previous/developerguide/grab.html) styles:
    ///
    /// * VectorGrabStandardLight, VectorGrabStandardDark – `Noto Sans Regular` |
    ///   `Noto Sans Medium` | `Noto Sans Bold`
    ///
    /// Valid font stacks for [Open
    /// Data](https://docs.aws.amazon.com/location/previous/developerguide/open-data.html) styles:
    ///
    /// * VectorOpenDataStandardLight, VectorOpenDataStandardDark,
    ///   VectorOpenDataVisualizationLight, VectorOpenDataVisualizationDark –
    ///   `Amazon Ember Regular,Noto Sans Regular` | `Amazon Ember Bold,Noto Sans
    ///   Bold` | `Amazon Ember Medium,Noto Sans Medium` | `Amazon Ember Regular
    ///   Italic,Noto Sans Italic` | `Amazon Ember Condensed RC Regular,Noto Sans
    ///   Regular` | `Amazon Ember Condensed RC Bold,Noto Sans Bold` | `Amazon Ember
    ///   Regular,Noto Sans Regular,Noto Sans Arabic Regular` | `Amazon Ember
    ///   Condensed RC Bold,Noto Sans Bold,Noto Sans Arabic Condensed Bold` |
    ///   `Amazon Ember Bold,Noto Sans Bold,Noto Sans Arabic Bold` | `Amazon Ember
    ///   Regular Italic,Noto Sans Italic,Noto Sans Arabic Regular` | `Amazon Ember
    ///   Condensed RC Regular,Noto Sans Regular,Noto Sans Arabic Condensed Regular`
    ///   | `Amazon Ember Medium,Noto Sans Medium,Noto Sans Arabic Medium`
    ///
    /// The fonts used by the Open Data map styles are combined fonts that use
    /// `Amazon Ember` for most glyphs but `Noto Sans` for glyphs unsupported by
    /// `Amazon Ember`.
    font_stack: []const u8,

    /// A Unicode range of characters to download glyphs for. Each response will
    /// contain 256 characters. For example, 0–255 includes all characters from
    /// range `U+0000` to `00FF`. Must be aligned to multiples of 256.
    font_unicode_range: []const u8,

    /// The optional [API
    /// key](https://docs.aws.amazon.com/location/previous/developerguide/using-apikeys.html) to authorize the request.
    key: ?[]const u8 = null,

    /// The map resource associated with the glyph ﬁle.
    map_name: []const u8,

    pub const json_field_names = .{
        .font_stack = "FontStack",
        .font_unicode_range = "FontUnicodeRange",
        .key = "Key",
        .map_name = "MapName",
    };
};

pub const GetMapGlyphsOutput = struct {
    /// The glyph, as binary blob.
    blob: ?[]const u8 = null,

    /// The HTTP Cache-Control directive for the value.
    cache_control: ?[]const u8 = null,

    /// The map glyph content type. For example, `application/octet-stream`.
    content_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .blob = "Blob",
        .cache_control = "CacheControl",
        .content_type = "ContentType",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMapGlyphsInput, options: Options) !GetMapGlyphsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "location");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetMapGlyphsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("location", "Location", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/maps/v0/maps/");
    try path_buf.appendSlice(alloc, input.map_name);
    try path_buf.appendSlice(alloc, "/glyphs/");
    try path_buf.appendSlice(alloc, input.font_stack);
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.font_unicode_range);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.key) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "key=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetMapGlyphsOutput {
    var result: GetMapGlyphsOutput = .{};
    if (body.len > 0) {
        result.blob = try alloc.dupe(u8, body);
    }
    _ = status;
    if (headers.get("cache-control")) |value| {
        result.cache_control = try alloc.dupe(u8, value);
    }
    if (headers.get("content-type")) |value| {
        result.content_type = try alloc.dupe(u8, value);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
