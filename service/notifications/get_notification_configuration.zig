const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AggregationDuration = @import("aggregation_duration.zig").AggregationDuration;
const NotificationConfigurationStatus = @import("notification_configuration_status.zig").NotificationConfigurationStatus;
const NotificationConfigurationSubtype = @import("notification_configuration_subtype.zig").NotificationConfigurationSubtype;

pub const GetNotificationConfigurationInput = struct {
    /// The Amazon Resource Name (ARN) of the `NotificationConfiguration` to return.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub const GetNotificationConfigurationOutput = struct {
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

    /// The ARN of the resource.
    arn: []const u8,

    /// The creation time of the `NotificationConfiguration`.
    creation_time: i64,

    /// The description of the `NotificationConfiguration`.
    description: []const u8,

    /// The name of the `NotificationConfiguration`.
    name: []const u8,

    /// The status of this `NotificationConfiguration`.
    status: NotificationConfigurationStatus,

    /// The subtype of the notification configuration returned in the response.
    subtype: ?NotificationConfigurationSubtype = null,

    pub const json_field_names = .{
        .aggregation_duration = "aggregationDuration",
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .name = "name",
        .status = "status",
        .subtype = "subtype",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetNotificationConfigurationInput, options: CallOptions) !GetNotificationConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetNotificationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/notification-configurations/");
    try path_buf.appendSlice(allocator, input.arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetNotificationConfigurationOutput {
    const result: GetNotificationConfigurationOutput = try aws.json.parseJsonObject(
        GetNotificationConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
