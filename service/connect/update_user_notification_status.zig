const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotificationStatus = @import("notification_status.zig").NotificationStatus;

pub const UpdateUserNotificationStatusInput = struct {
    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The AWS Region where the notification status was last modified. Used for
    /// cross-region replication.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when the notification status was last modified. Used for
    /// cross-region replication and optimistic locking.
    last_modified_time: ?i64 = null,

    /// The unique identifier for the notification.
    notification_id: []const u8,

    /// The new status for the notification. Valid values are READ, UNREAD, and
    /// HIDDEN.
    status: NotificationStatus,

    /// The identifier of the user whose notification status is being updated.
    user_id: []const u8,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .notification_id = "NotificationId",
        .status = "Status",
        .user_id = "UserId",
    };
};

pub const UpdateUserNotificationStatusOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateUserNotificationStatusInput, options: CallOptions) !UpdateUserNotificationStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateUserNotificationStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/users/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.user_id);
    try path_buf.appendSlice(allocator, "/notifications/");
    try path_buf.appendSlice(allocator, input.notification_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Status\":");
    try aws.json.writeValue(@TypeOf(input.status), input.status, allocator, &body_buf);
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
    if (input.last_modified_region) |v| {
        try request.headers.put(allocator, "x-amz-last-modified-region", v);
    }
    if (input.last_modified_time) |v| {
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try request.headers.put(allocator, "x-amz-last-modified-time", num_str);
        }
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateUserNotificationStatusOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateUserNotificationStatusOutput = .{};

    return result;
}
