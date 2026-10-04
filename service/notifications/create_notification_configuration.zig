const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AggregationDuration = @import("aggregation_duration.zig").AggregationDuration;
const NotificationConfigurationStatus = @import("notification_configuration_status.zig").NotificationConfigurationStatus;

pub const CreateNotificationConfigurationInput = struct {
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

    /// The description of the `NotificationConfiguration`.
    description: []const u8,

    /// The name of the `NotificationConfiguration`. Supports RFC 3986's unreserved
    /// characters.
    name: []const u8,

    /// A map of tags assigned to a resource. A tag is a string-to-string map of
    /// key-value pairs.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .aggregation_duration = "aggregationDuration",
        .description = "description",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateNotificationConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the `NotificationConfiguration`.
    arn: []const u8,

    /// The current status of this `NotificationConfiguration`.
    status: NotificationConfigurationStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNotificationConfigurationInput, options: CallOptions) !CreateNotificationConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNotificationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/notification-configurations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.aggregation_duration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"aggregationDuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNotificationConfigurationOutput {
    const result: CreateNotificationConfigurationOutput = try aws.json.parseJsonObject(
        CreateNotificationConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
