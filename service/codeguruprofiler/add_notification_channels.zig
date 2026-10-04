const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Channel = @import("channel.zig").Channel;
const NotificationConfiguration = @import("notification_configuration.zig").NotificationConfiguration;

pub const AddNotificationChannelsInput = struct {
    /// One or 2 channels to report to when anomalies are detected.
    channels: []const Channel,

    /// The name of the profiling group that we are setting up notifications for.
    profiling_group_name: []const u8,

    pub const json_field_names = .{
        .channels = "channels",
        .profiling_group_name = "profilingGroupName",
    };
};

pub const AddNotificationChannelsOutput = struct {
    /// The new notification configuration for this profiling group.
    notification_configuration: ?NotificationConfiguration = null,

    pub const json_field_names = .{
        .notification_configuration = "notificationConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddNotificationChannelsInput, options: CallOptions) !AddNotificationChannelsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-profiler", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: AddNotificationChannelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-profiler", "CodeGuruProfiler", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/profilingGroups/");
    try path_buf.appendSlice(allocator, input.profiling_group_name);
    try path_buf.appendSlice(allocator, "/notificationConfiguration");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"channels\":");
    try aws.json.writeValue(@TypeOf(input.channels), input.channels, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddNotificationChannelsOutput {
    const result: AddNotificationChannelsOutput = try aws.json.parseJsonObject(
        AddNotificationChannelsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
