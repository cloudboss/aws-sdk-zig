const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventRuleStatusSummary = @import("event_rule_status_summary.zig").EventRuleStatusSummary;

pub const UpdateEventRuleInput = struct {
    /// The Amazon Resource Name (ARN) to use to update the `EventRule`.
    arn: []const u8,

    /// An additional event pattern used to further filter the events this
    /// `EventRule` receives.
    ///
    /// For more information, see [Amazon EventBridge event
    /// patterns](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-patterns.html) in the *Amazon EventBridge User Guide.*
    event_pattern: ?[]const u8 = null,

    /// A list of Amazon Web Services Regions that sends events to this `EventRule`.
    regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .event_pattern = "eventPattern",
        .regions = "regions",
    };
};

pub const UpdateEventRuleOutput = struct {
    /// The Amazon Resource Name (ARN) to use to update the `EventRule`.
    arn: []const u8,

    /// The ARN of the `NotificationConfiguration`.
    notification_configuration_arn: []const u8,

    /// The status of the action by Region.
    status_summary_by_region: ?[]const aws.map.MapEntry(EventRuleStatusSummary) = null,

    pub const json_field_names = .{
        .arn = "arn",
        .notification_configuration_arn = "notificationConfigurationArn",
        .status_summary_by_region = "statusSummaryByRegion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEventRuleInput, options: CallOptions) !UpdateEventRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEventRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/event-rules/");
    try path_buf.appendSlice(allocator, input.arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.event_pattern) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"eventPattern\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"regions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEventRuleOutput {
    const result: UpdateEventRuleOutput = try aws.json.parseJsonObject(
        UpdateEventRuleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
