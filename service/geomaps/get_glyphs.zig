const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const GetGlyphsInput = struct {
    /// Name of the `FontStack` to retrieve.
    ///
    /// Example: `Amazon Ember Bold,Noto Sans Bold`.
    ///
    /// The supported font stacks are as follows:
    ///
    /// * Amazon Ember Bold
    /// * Amazon Ember Bold Italic
    /// * Amazon Ember Bold,Noto Sans Bold
    /// * Amazon Ember Bold,Noto Sans Bold,Noto Sans Arabic Bold
    /// * Amazon Ember Condensed RC BdItalic
    /// * Amazon Ember Condensed RC Bold
    /// * Amazon Ember Condensed RC Bold Italic
    /// * Amazon Ember Condensed RC Bold,Noto Sans Bold
    /// * Amazon Ember Condensed RC Bold,Noto Sans Bold,Noto Sans Arabic Condensed
    ///   Bold
    /// * Amazon Ember Condensed RC Light
    /// * Amazon Ember Condensed RC Light Italic
    /// * Amazon Ember Condensed RC LtItalic
    /// * Amazon Ember Condensed RC Regular
    /// * Amazon Ember Condensed RC Regular Italic
    /// * Amazon Ember Condensed RC Regular,Noto Sans Regular
    /// * Amazon Ember Condensed RC Regular,Noto Sans Regular,Noto Sans Arabic
    ///   Condensed Regular
    /// * Amazon Ember Condensed RC RgItalic
    /// * Amazon Ember Condensed RC ThItalic
    /// * Amazon Ember Condensed RC Thin
    /// * Amazon Ember Condensed RC Thin Italic
    /// * Amazon Ember Heavy
    /// * Amazon Ember Heavy Italic
    /// * Amazon Ember Light
    /// * Amazon Ember Light Italic
    /// * Amazon Ember Medium
    /// * Amazon Ember Medium Italic
    /// * Amazon Ember Medium,Noto Sans Medium
    /// * Amazon Ember Medium,Noto Sans Medium,Noto Sans Arabic Medium
    /// * Amazon Ember Regular
    /// * Amazon Ember Regular Italic
    /// * Amazon Ember Regular Italic,Noto Sans Italic
    /// * Amazon Ember Regular Italic,Noto Sans Italic,Noto Sans Arabic Regular
    /// * Amazon Ember Regular,Noto Sans Regular
    /// * Amazon Ember Regular,Noto Sans Regular,Noto Sans Arabic Regular
    /// * Amazon Ember Thin
    /// * Amazon Ember Thin Italic
    /// * AmazonEmberCdRC_Bd
    /// * AmazonEmberCdRC_BdIt
    /// * AmazonEmberCdRC_Lt
    /// * AmazonEmberCdRC_LtIt
    /// * AmazonEmberCdRC_Rg
    /// * AmazonEmberCdRC_RgIt
    /// * AmazonEmberCdRC_Th
    /// * AmazonEmberCdRC_ThIt
    /// * AmazonEmber_Bd
    /// * AmazonEmber_BdIt
    /// * AmazonEmber_He
    /// * AmazonEmber_HeIt
    /// * AmazonEmber_Lt
    /// * AmazonEmber_LtIt
    /// * AmazonEmber_Md
    /// * AmazonEmber_MdIt
    /// * AmazonEmber_Rg
    /// * AmazonEmber_RgIt
    /// * AmazonEmber_Th
    /// * AmazonEmber_ThIt
    /// * Noto Sans Black
    /// * Noto Sans Black Italic
    /// * Noto Sans Bold
    /// * Noto Sans Bold Italic
    /// * Noto Sans Extra Bold
    /// * Noto Sans Extra Bold Italic
    /// * Noto Sans Extra Light
    /// * Noto Sans Extra Light Italic
    /// * Noto Sans Italic
    /// * Noto Sans Light
    /// * Noto Sans Light Italic
    /// * Noto Sans Medium
    /// * Noto Sans Medium Italic
    /// * Noto Sans Regular
    /// * Noto Sans Semi Bold
    /// * Noto Sans Semi Bold Italic
    /// * Noto Sans Thin
    /// * Noto Sans Thin Italic
    /// * NotoSans-Bold
    /// * NotoSans-Italic
    /// * NotoSans-Medium
    /// * NotoSans-Regular
    /// * Open Sans Regular,Arial Unicode MS Regular
    font_stack: []const u8,

    /// A Unicode range of characters to download glyphs for. This must be aligned
    /// to multiples of 256.
    ///
    /// Example: `0-255.pbf`
    font_unicode_range: []const u8,

    pub const json_field_names = .{
        .font_stack = "FontStack",
        .font_unicode_range = "FontUnicodeRange",
    };
};

pub const GetGlyphsOutput = struct {
    /// The Glyph, as a binary blob.
    blob: ?[]const u8 = null,

    /// Header that instructs caching configuration for the client.
    cache_control: ?[]const u8 = null,

    /// Header that represents the format of the response. The response returns the
    /// following as the HTTP body.
    content_type: ?[]const u8 = null,

    /// The glyph's Etag.
    e_tag: ?[]const u8 = null,

    pub const json_field_names = .{
        .blob = "Blob",
        .cache_control = "CacheControl",
        .content_type = "ContentType",
        .e_tag = "ETag",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGlyphsInput, options: Options) !GetGlyphsOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetGlyphsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geomaps", "Geo Maps", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/glyphs/");
    try path_buf.appendSlice(alloc, input.font_stack);
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.font_unicode_range);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetGlyphsOutput {
    var result: GetGlyphsOutput = .{};
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
    if (headers.get("etag")) |value| {
        result.e_tag = try alloc.dupe(u8, value);
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
