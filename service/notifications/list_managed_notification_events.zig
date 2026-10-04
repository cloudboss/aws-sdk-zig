const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LocaleCode = @import("locale_code.zig").LocaleCode;
const ManagedNotificationEventOverview = @import("managed_notification_event_overview.zig").ManagedNotificationEventOverview;

pub const ListManagedNotificationEventsInput = struct {
    /// Latest time of events to return from this call.
    end_time: ?i64 = null,

    /// Specifies whether to include sensitive events in the result. By default,
    /// only non-sensitive events are returned. The
    /// `notifications:AccessSensitiveEvents` permission controls access to
    /// sensitive events.
    include_sensitive_events: ?bool = null,

    /// The locale code of the language used for the retrieved NotificationEvent.
    /// The default locale is English (en_US).
    locale: ?LocaleCode = null,

    /// The maximum number of results to be returned in this call. Defaults to 20.
    max_results: ?i32 = null,

    /// The start token for paginated calls. Retrieved from the response of a
    /// previous `ListManagedNotificationChannelAssociations` call. Next token uses
    /// Base64 encoding.
    next_token: ?[]const u8 = null,

    /// The Organizational Unit Id that an Amazon Web Services account belongs to.
    organizational_unit_id: ?[]const u8 = null,

    /// The Amazon Web Services account ID associated with the Managed Notification
    /// Events.
    related_account: ?[]const u8 = null,

    /// The Amazon Web Services service the event originates from. For example
    /// aws.cloudwatch.
    source: ?[]const u8 = null,

    /// The earliest time of events to return from this call.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .include_sensitive_events = "includeSensitiveEvents",
        .locale = "locale",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .organizational_unit_id = "organizationalUnitId",
        .related_account = "relatedAccount",
        .source = "source",
        .start_time = "startTime",
    };
};

pub const ListManagedNotificationEventsOutput = struct {
    /// A list of Managed Notification Events matching the request criteria.
    managed_notification_events: ?[]const ManagedNotificationEventOverview = null,

    /// A pagination token. If a non-null pagination token is returned in a result,
    /// pass its value in another request to retrieve more entries.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .managed_notification_events = "managedNotificationEvents",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListManagedNotificationEventsInput, options: CallOptions) !ListManagedNotificationEventsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListManagedNotificationEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/managed-notification-events";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.end_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "endTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.include_sensitive_events) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeSensitiveEvents=");
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
    if (input.related_account) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "relatedAccount=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListManagedNotificationEventsOutput {
    const result: ListManagedNotificationEventsOutput = try aws.json.parseJsonObject(
        ListManagedNotificationEventsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
