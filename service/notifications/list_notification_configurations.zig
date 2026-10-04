const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotificationConfigurationStatus = @import("notification_configuration_status.zig").NotificationConfigurationStatus;
const NotificationConfigurationSubtype = @import("notification_configuration_subtype.zig").NotificationConfigurationSubtype;
const NotificationConfigurationStructure = @import("notification_configuration_structure.zig").NotificationConfigurationStructure;

pub const ListNotificationConfigurationsInput = struct {
    /// The Amazon Resource Name (ARN) of the Channel to match.
    channel_arn: ?[]const u8 = null,

    /// The matched event source.
    ///
    /// Must match one of the valid EventBridge sources. Only Amazon Web Services
    /// service sourced events are supported. For example, `aws.ec2` and
    /// `aws.cloudwatch`. For more information, see [Event delivery from Amazon Web
    /// Services
    /// services](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-service-event.html#eb-service-event-delivery-level) in the *Amazon EventBridge User Guide*.
    event_rule_source: ?[]const u8 = null,

    /// The maximum number of results to be returned in this call. Defaults to 20.
    max_results: ?i32 = null,

    /// The start token for paginated calls. Retrieved from the response of a
    /// previous `ListEventRules` call. Next token uses Base64 encoding.
    next_token: ?[]const u8 = null,

    /// The `NotificationConfiguration` status to match.
    ///
    /// * Values:
    ///
    /// * `ACTIVE`
    ///
    /// * All `EventRules` are `ACTIVE` and any call can be run.
    ///
    /// * `PARTIALLY_ACTIVE`
    ///
    /// * Some `EventRules` are `ACTIVE` and some are `INACTIVE`. Any call can be
    ///   run.
    /// * Any call can be run.
    ///
    /// * `INACTIVE`
    ///
    /// * All `EventRules` are `INACTIVE` and any call can be run.
    ///
    /// * `DELETING`
    ///
    /// * This `NotificationConfiguration` is being deleted.
    /// * Only `GET` and `LIST` calls can be run.
    status: ?NotificationConfigurationStatus = null,

    /// The subtype used to filter the notification configurations in the request.
    subtype: ?NotificationConfigurationSubtype = null,

    pub const json_field_names = .{
        .channel_arn = "channelArn",
        .event_rule_source = "eventRuleSource",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .status = "status",
        .subtype = "subtype",
    };
};

pub const ListNotificationConfigurationsOutput = struct {
    /// A pagination token. If a non-null pagination token is returned in a result,
    /// pass its value in another request to retrieve more entries.
    next_token: ?[]const u8 = null,

    /// The `NotificationConfigurations` in the account.
    notification_configurations: ?[]const NotificationConfigurationStructure = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .notification_configurations = "notificationConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListNotificationConfigurationsInput, options: CallOptions) !ListNotificationConfigurationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListNotificationConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/notification-configurations";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.channel_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "channelArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.event_rule_source) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "eventRuleSource=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.subtype) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "subtype=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNotificationConfigurationsOutput {
    var result: ListNotificationConfigurationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListNotificationConfigurationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
