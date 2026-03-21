const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ChannelState = @import("channel_state.zig").ChannelState;
const SlateSource = @import("slate_source.zig").SlateSource;
const LogConfigurationForChannel = @import("log_configuration_for_channel.zig").LogConfigurationForChannel;
const ResponseOutputItem = @import("response_output_item.zig").ResponseOutputItem;
const TimeShiftConfiguration = @import("time_shift_configuration.zig").TimeShiftConfiguration;

pub const DescribeChannelInput = struct {
    /// The name of the channel.
    channel_name: []const u8,

    pub const json_field_names = .{
        .channel_name = "ChannelName",
    };
};

pub const DescribeChannelOutput = struct {
    /// The ARN of the channel.
    arn: ?[]const u8 = null,

    /// The list of audiences defined in channel.
    audiences: ?[]const []const u8 = null,

    /// The name of the channel.
    channel_name: ?[]const u8 = null,

    /// Indicates whether the channel is in a running state or not.
    channel_state: ?ChannelState = null,

    /// The timestamp of when the channel was created.
    creation_time: ?i64 = null,

    /// Contains information about the slate used to fill gaps between programs in
    /// the schedule.
    filler_slate: ?SlateSource = null,

    /// The timestamp of when the channel was last modified.
    last_modified_time: ?i64 = null,

    /// The log configuration for the channel.
    log_configuration: ?LogConfigurationForChannel = null,

    /// The channel's output properties.
    outputs: ?[]const ResponseOutputItem = null,

    /// The channel's playback mode.
    playback_mode: ?[]const u8 = null,

    /// The tags assigned to the channel. Tags are key-value pairs that you can
    /// associate with Amazon resources to help with organization, access control,
    /// and cost tracking. For more information, see [Tagging AWS Elemental
    /// MediaTailor
    /// Resources](https://docs.aws.amazon.com/mediatailor/latest/ug/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The channel's tier.
    tier: ?[]const u8 = null,

    /// The time-shifted viewing configuration for the channel.
    time_shift_configuration: ?TimeShiftConfiguration = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .audiences = "Audiences",
        .channel_name = "ChannelName",
        .channel_state = "ChannelState",
        .creation_time = "CreationTime",
        .filler_slate = "FillerSlate",
        .last_modified_time = "LastModifiedTime",
        .log_configuration = "LogConfiguration",
        .outputs = "Outputs",
        .playback_mode = "PlaybackMode",
        .tags = "Tags",
        .tier = "Tier",
        .time_shift_configuration = "TimeShiftConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeChannelInput, options: CallOptions) !DescribeChannelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.mediatailor", "MediaTailor", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/channel/");
    try path_buf.appendSlice(allocator, input.channel_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeChannelOutput {
    var result: DescribeChannelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeChannelOutput, body, allocator);
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
