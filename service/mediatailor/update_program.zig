const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AdBreak = @import("ad_break.zig").AdBreak;
const AudienceMedia = @import("audience_media.zig").AudienceMedia;
const UpdateProgramScheduleConfiguration = @import("update_program_schedule_configuration.zig").UpdateProgramScheduleConfiguration;
const ClipRange = @import("clip_range.zig").ClipRange;

pub const UpdateProgramInput = struct {
    /// The ad break configuration settings.
    ad_breaks: ?[]const AdBreak = null,

    /// The list of AudienceMedia defined in program.
    audience_media: ?[]const AudienceMedia = null,

    /// The name of the channel for this Program.
    channel_name: []const u8,

    /// The name of the Program.
    program_name: []const u8,

    /// The schedule configuration settings.
    schedule_configuration: UpdateProgramScheduleConfiguration,

    pub const json_field_names = .{
        .ad_breaks = "AdBreaks",
        .audience_media = "AudienceMedia",
        .channel_name = "ChannelName",
        .program_name = "ProgramName",
        .schedule_configuration = "ScheduleConfiguration",
    };
};

pub const UpdateProgramOutput = struct {
    /// The ad break configuration settings.
    ad_breaks: ?[]const AdBreak = null,

    /// The ARN to assign to the program.
    arn: ?[]const u8 = null,

    /// The list of AudienceMedia defined in program.
    audience_media: ?[]const AudienceMedia = null,

    /// The name to assign to the channel for this program.
    channel_name: ?[]const u8 = null,

    /// The clip range configuration settings.
    clip_range: ?ClipRange = null,

    /// The time the program was created.
    creation_time: ?i64 = null,

    /// The duration of the live program in milliseconds.
    duration_millis: ?i64 = null,

    /// The name of the LiveSource for this Program.
    live_source_name: ?[]const u8 = null,

    /// The name to assign to this program.
    program_name: ?[]const u8 = null,

    /// The scheduled start time for this Program.
    scheduled_start_time: ?i64 = null,

    /// The name to assign to the source location for this program.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProgramInput, options: Options) !UpdateProgramOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProgramInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediatailor", "MediaTailor", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/channel/");
    try path_buf.appendSlice(allocator, input.channel_name);
    try path_buf.appendSlice(allocator, "/program/");
    try path_buf.appendSlice(allocator, input.program_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.ad_breaks) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AdBreaks\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.audience_media) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AudienceMedia\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ScheduleConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.schedule_configuration), input.schedule_configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProgramOutput {
    var result: UpdateProgramOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateProgramOutput, body, allocator);
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
