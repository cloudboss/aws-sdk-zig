const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskStatus = @import("task_status.zig").TaskStatus;
const NotificationType = @import("notification_type.zig").NotificationType;
const NotificationOutput = @import("notification_output.zig").NotificationOutput;

pub const ListNotificationsInput = struct {
    /// The time after which you want to list notifications.
    after_timestamp: ?i64 = null,

    /// The time before which you want to list notifications.
    before_timestamp: ?i64 = null,

    /// The identifier of the Amazon DataZone domain.
    domain_identifier: []const u8,

    /// The maximum number of notifications to return in a single call to
    /// `ListNotifications`. When the number of notifications to be listed is
    /// greater than the value of `MaxResults`, the response contains a `NextToken`
    /// value that you can use in a subsequent call to `ListNotifications` to list
    /// the next set of notifications.
    max_results: ?i32 = null,

    /// When the number of notifications is greater than the default value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of notifications, the response
    /// includes a pagination token named `NextToken`. You can specify this
    /// `NextToken` value in a subsequent call to `ListNotifications` to list the
    /// next set of notifications.
    next_token: ?[]const u8 = null,

    /// The subjects of notifications.
    subjects: ?[]const []const u8 = null,

    /// The task status of notifications.
    task_status: ?TaskStatus = null,

    /// The type of notifications.
    type: NotificationType,

    pub const json_field_names = .{
        .after_timestamp = "afterTimestamp",
        .before_timestamp = "beforeTimestamp",
        .domain_identifier = "domainIdentifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .subjects = "subjects",
        .task_status = "taskStatus",
        .type = "type",
    };
};

pub const ListNotificationsOutput = struct {
    /// When the number of notifications is greater than the default value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of notifications, the response
    /// includes a pagination token named `NextToken`. You can specify this
    /// `NextToken` value in a subsequent call to `ListNotifications` to list the
    /// next set of notifications.
    next_token: ?[]const u8 = null,

    /// The results of the `ListNotifications` action.
    notifications: ?[]const NotificationOutput = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .notifications = "notifications",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListNotificationsInput, options: CallOptions) !ListNotificationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListNotificationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/notifications");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.after_timestamp) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "afterTimestamp=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.before_timestamp) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "beforeTimestamp=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.subjects) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "subjects=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.task_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "taskStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "type=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.type.wireName());
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNotificationsOutput {
    const result: ListNotificationsOutput = try aws.json.parseJsonObject(
        ListNotificationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
