const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PrefetchConsumption = @import("prefetch_consumption.zig").PrefetchConsumption;
const RecurringPrefetchConfiguration = @import("recurring_prefetch_configuration.zig").RecurringPrefetchConfiguration;
const PrefetchRetrieval = @import("prefetch_retrieval.zig").PrefetchRetrieval;
const PrefetchScheduleType = @import("prefetch_schedule_type.zig").PrefetchScheduleType;

pub const GetPrefetchScheduleInput = struct {
    /// The name of the prefetch schedule. The name must be unique among all
    /// prefetch schedules that are associated with the specified playback
    /// configuration.
    name: []const u8,

    /// Returns information about the prefetch schedule for a specific playback
    /// configuration. If you call `GetPrefetchSchedule` on an expired prefetch
    /// schedule, MediaTailor returns an HTTP 404 status code.
    playback_configuration_name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .playback_configuration_name = "PlaybackConfigurationName",
    };
};

pub const GetPrefetchScheduleOutput = struct {
    /// The Amazon Resource Name (ARN) of the prefetch schedule.
    arn: ?[]const u8 = null,

    /// The configuration settings for how and when MediaTailor consumes prefetched
    /// ads from the ad decision server for single prefetch schedules. Each
    /// consumption configuration contains an end time and an optional start time
    /// that define the *consumption window*. Prefetch schedules automatically
    /// expire no earlier than seven days after the end time.
    consumption: ?PrefetchConsumption = null,

    /// The name of the prefetch schedule. The name must be unique among all
    /// prefetch schedules that are associated with the specified playback
    /// configuration.
    name: ?[]const u8 = null,

    /// The name of the playback configuration to create the prefetch schedule for.
    playback_configuration_name: ?[]const u8 = null,

    /// The configuration that defines how and when MediaTailor performs ad
    /// prefetching in a live event.
    recurring_prefetch_configuration: ?RecurringPrefetchConfiguration = null,

    /// A complex type that contains settings for prefetch retrieval from the ad
    /// decision server (ADS).
    retrieval: ?PrefetchRetrieval = null,

    /// The frequency that MediaTailor creates prefetch schedules. `SINGLE`
    /// indicates that this schedule applies to one ad break. `RECURRING` indicates
    /// that MediaTailor automatically creates a schedule for each ad avail in a
    /// live event.
    schedule_type: ?PrefetchScheduleType = null,

    /// An optional stream identifier that you can specify in order to prefetch for
    /// multiple streams that use the same playback configuration.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .consumption = "Consumption",
        .name = "Name",
        .playback_configuration_name = "PlaybackConfigurationName",
        .recurring_prefetch_configuration = "RecurringPrefetchConfiguration",
        .retrieval = "Retrieval",
        .schedule_type = "ScheduleType",
        .stream_id = "StreamId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPrefetchScheduleInput, options: CallOptions) !GetPrefetchScheduleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPrefetchScheduleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.mediatailor", "MediaTailor", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/prefetchSchedule/");
    try path_buf.appendSlice(allocator, input.playback_configuration_name);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPrefetchScheduleOutput {
    var result: GetPrefetchScheduleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPrefetchScheduleOutput, body, allocator);
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
