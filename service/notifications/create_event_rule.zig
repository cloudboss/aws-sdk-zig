const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventRuleStatusSummary = @import("event_rule_status_summary.zig").EventRuleStatusSummary;

pub const CreateEventRuleInput = struct {
    /// An additional event pattern used to further filter the events this
    /// `EventRule` receives.
    ///
    /// For more information, see [Amazon EventBridge event
    /// patterns](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-patterns.html) in the *Amazon EventBridge User Guide.*
    event_pattern: ?[]const u8 = null,

    /// The event type to match.
    ///
    /// Must match one of the valid Amazon EventBridge event types. For example, EC2
    /// Instance State-change Notification and Amazon CloudWatch Alarm State Change.
    /// For more information, see [Event delivery from Amazon Web Services
    /// services](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-service-event.html#eb-service-event-delivery-level) in the *Amazon EventBridge User Guide*.
    event_type: []const u8,

    /// The Amazon Resource Name (ARN) of the `NotificationConfiguration` associated
    /// with this `EventRule`.
    notification_configuration_arn: []const u8,

    /// A list of Amazon Web Services Regions that send events to this `EventRule`.
    regions: []const []const u8,

    /// The matched event source.
    ///
    /// Must match one of the valid EventBridge sources. Only Amazon Web Services
    /// service sourced events are supported. For example, `aws.ec2` and
    /// `aws.cloudwatch`. For more information, see [Event delivery from Amazon Web
    /// Services
    /// services](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-service-event.html#eb-service-event-delivery-level) in the *Amazon EventBridge User Guide*.
    source: []const u8,

    pub const json_field_names = .{
        .event_pattern = "eventPattern",
        .event_type = "eventType",
        .notification_configuration_arn = "notificationConfigurationArn",
        .regions = "regions",
        .source = "source",
    };
};

pub const CreateEventRuleOutput = struct {
    /// The ARN of the resource.
    arn: []const u8,

    /// The ARN of a `NotificationConfiguration`.
    notification_configuration_arn: []const u8,

    /// A list of an `EventRule`'s status by Region. Regions are mapped to
    /// `EventRuleStatusSummary`.
    status_summary_by_region: ?[]const aws.map.MapEntry(EventRuleStatusSummary) = null,

    pub const json_field_names = .{
        .arn = "arn",
        .notification_configuration_arn = "notificationConfigurationArn",
        .status_summary_by_region = "statusSummaryByRegion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEventRuleInput, options: CallOptions) !CreateEventRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEventRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/event-rules";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.event_pattern) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"eventPattern\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"eventType\":");
    try aws.json.writeValue(@TypeOf(input.event_type), input.event_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"notificationConfigurationArn\":");
    try aws.json.writeValue(@TypeOf(input.notification_configuration_arn), input.notification_configuration_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"regions\":");
    try aws.json.writeValue(@TypeOf(input.regions), input.regions, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"source\":");
    try aws.json.writeValue(@TypeOf(input.source), input.source, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEventRuleOutput {
    var result: CreateEventRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateEventRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
