const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LocaleCode = @import("locale_code.zig").LocaleCode;
const NotificationEventOverview = @import("notification_event_overview.zig").NotificationEventOverview;

pub const ListNotificationEventsInput = struct {
    /// The Amazon Resource Name (ARN) of the `aggregatedNotificationEventArn` to
    /// match.
    aggregate_notification_event_arn: ?[]const u8 = null,

    /// Latest time of events to return from this call.
    end_time: ?i64 = null,

    /// Include aggregated child events in the result.
    include_child_events: ?bool = null,

    /// The locale code of the language used for the retrieved `NotificationEvent`.
    /// The default locale is English `(en_US)`.
    locale: ?LocaleCode = null,

    /// The maximum number of results to be returned in this call. Defaults to 20.
    max_results: ?i32 = null,

    /// The start token for paginated calls. Retrieved from the response of a
    /// previous `ListEventRules` call. Next token uses Base64 encoding.
    next_token: ?[]const u8 = null,

    /// The unique identifier of the organizational unit used to filter notification
    /// events.
    organizational_unit_id: ?[]const u8 = null,

    /// The matched event source.
    ///
    /// Must match one of the valid EventBridge sources. Only Amazon Web Services
    /// service sourced events are supported. For example, `aws.ec2` and
    /// `aws.cloudwatch`. For more information, see [Event delivery from Amazon Web
    /// Services
    /// services](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-service-event.html#eb-service-event-delivery-level) in the *Amazon EventBridge User Guide*.
    source: ?[]const u8 = null,

    /// The earliest time of events to return from this call.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .aggregate_notification_event_arn = "aggregateNotificationEventArn",
        .end_time = "endTime",
        .include_child_events = "includeChildEvents",
        .locale = "locale",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .organizational_unit_id = "organizationalUnitId",
        .source = "source",
        .start_time = "startTime",
    };
};

pub const ListNotificationEventsOutput = struct {
    /// A pagination token. If a non-null pagination token is returned in a result,
    /// pass its value in another request to retrieve more entries.
    next_token: ?[]const u8 = null,

    /// The list of notification events.
    notification_events: ?[]const NotificationEventOverview = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .notification_events = "notificationEvents",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListNotificationEventsInput, options: CallOptions) !ListNotificationEventsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListNotificationEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/notification-events";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.aggregate_notification_event_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "aggregateNotificationEventArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.end_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "endTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.include_child_events) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeChildEvents=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.locale) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "locale=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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
    if (input.organizational_unit_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "organizationalUnitId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.source) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "source=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.start_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNotificationEventsOutput {
    var result: ListNotificationEventsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListNotificationEventsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
