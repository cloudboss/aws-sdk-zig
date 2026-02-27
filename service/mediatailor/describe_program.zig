const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AdBreak = @import("ad_break.zig").AdBreak;
const AudienceMedia = @import("audience_media.zig").AudienceMedia;
const ClipRange = @import("clip_range.zig").ClipRange;

pub const DescribeProgramInput = struct {
    /// The name of the channel associated with this Program.
    channel_name: []const u8,

    /// The name of the program.
    program_name: []const u8,

    pub const json_field_names = .{
        .channel_name = "ChannelName",
        .program_name = "ProgramName",
    };
};

pub const DescribeProgramOutput = struct {
    /// The ad break configuration settings.
    ad_breaks: ?[]const AdBreak = null,

    /// The ARN of the program.
    arn: ?[]const u8 = null,

    /// The list of AudienceMedia defined in program.
    audience_media: ?[]const AudienceMedia = null,

    /// The name of the channel that the program belongs to.
    channel_name: ?[]const u8 = null,

    /// The clip range configuration settings.
    clip_range: ?ClipRange = null,

    /// The timestamp of when the program was created.
    creation_time: ?i64 = null,

    /// The duration of the live program in milliseconds.
    duration_millis: ?i64 = null,

    /// The name of the LiveSource for this Program.
    live_source_name: ?[]const u8 = null,

    /// The name of the program.
    program_name: ?[]const u8 = null,

    /// The date and time that the program is scheduled to start in ISO 8601 format
    /// and Coordinated Universal Time (UTC). For example, the value
    /// 2021-03-27T17:48:16.751Z represents March 27, 2021 at 17:48:16.751 UTC.
    scheduled_start_time: ?i64 = null,

    /// The source location name.
    source_location_name: ?[]const u8 = null,

    /// The name that's used to refer to a VOD source.
    vod_source_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .ad_breaks = "AdBreaks",
        .arn = "Arn",
        .audience_media = "AudienceMedia",
        .channel_name = "ChannelName",
        .clip_range = "ClipRange",
        .creation_time = "CreationTime",
        .duration_millis = "DurationMillis",
        .live_source_name = "LiveSourceName",
        .program_name = "ProgramName",
        .scheduled_start_time = "ScheduledStartTime",
        .source_location_name = "SourceLocationName",
        .vod_source_name = "VodSourceName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProgramInput, options: Options) !DescribeProgramOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mediatailor");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeProgramInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediatailor", "MediaTailor", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/channel/");
    try path_buf.appendSlice(alloc, input.channel_name);
    try path_buf.appendSlice(alloc, "/program/");
    try path_buf.appendSlice(alloc, input.program_name);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeProgramOutput {
    var result: DescribeProgramOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeProgramOutput, body, alloc);
    }
    _ = status;
    _ = headers;

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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
