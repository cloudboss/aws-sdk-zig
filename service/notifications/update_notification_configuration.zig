const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AggregationDuration = @import("aggregation_duration.zig").AggregationDuration;

pub const UpdateNotificationConfigurationInput = struct {
    /// The aggregation preference of the `NotificationConfiguration`.
    ///
    /// * Values:
    ///
    /// * `LONG`
    ///
    /// * Aggregate notifications for long periods of time (12 hours).
    ///
    /// * `SHORT`
    ///
    /// * Aggregate notifications for short periods of time (5 minutes).
    ///
    /// * `NONE`
    ///
    /// * Don't aggregate notifications.
    aggregation_duration: ?AggregationDuration = null,

    /// The Amazon Resource Name (ARN) used to update the
    /// `NotificationConfiguration`.
    arn: []const u8,

    /// The description of the `NotificationConfiguration`.
    description: ?[]const u8 = null,

    /// The name of the `NotificationConfiguration`.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregation_duration = "aggregationDuration",
        .arn = "arn",
        .description = "description",
        .name = "name",
    };
};

pub const UpdateNotificationConfigurationOutput = struct {
    /// The ARN used to update the `NotificationConfiguration`.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNotificationConfigurationInput, options: CallOptions) !UpdateNotificationConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "notifications", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateNotificationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/notification-configurations/");
    try path_buf.appendSlice(allocator, input.arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.aggregation_duration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"aggregationDuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateNotificationConfigurationOutput {
    var result: UpdateNotificationConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateNotificationConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
