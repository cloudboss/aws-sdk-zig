const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChatChannel = @import("chat_channel.zig").ChatChannel;
const NotificationTargetItem = @import("notification_target_item.zig").NotificationTargetItem;
const IncidentRecordStatus = @import("incident_record_status.zig").IncidentRecordStatus;

pub const UpdateIncidentRecordInput = struct {
    /// The Amazon Resource Name (ARN) of the incident record you are updating.
    arn: []const u8,

    /// The Chatbot chat channel where responders can collaborate.
    chat_channel: ?ChatChannel = null,

    /// A token that ensures that a client calls the operation only once with the
    /// specified
    /// details.
    client_token: ?[]const u8 = null,

    /// Defines the impact of the incident to customers and applications. If you
    /// provide an impact
    /// for an incident, it overwrites the impact provided by the response plan.
    ///
    /// **Supported impact codes**
    ///
    /// * `1` - Critical
    ///
    /// * `2` - High
    ///
    /// * `3` - Medium
    ///
    /// * `4` - Low
    ///
    /// * `5` - No Impact
    impact: ?i32 = null,

    /// The Amazon SNS targets that Incident Manager notifies when a client updates
    /// an
    /// incident.
    ///
    /// Using multiple SNS topics creates redundancy in the event that a Region is
    /// down during the
    /// incident.
    notification_targets: ?[]const NotificationTargetItem = null,

    /// The status of the incident. Possible statuses are `Open` or
    /// `Resolved`.
    status: ?IncidentRecordStatus = null,

    /// A longer description of what occurred during the incident.
    summary: ?[]const u8 = null,

    /// A brief description of the incident.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .chat_channel = "chatChannel",
        .client_token = "clientToken",
        .impact = "impact",
        .notification_targets = "notificationTargets",
        .status = "status",
        .summary = "summary",
        .title = "title",
    };
};

pub const UpdateIncidentRecordOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIncidentRecordInput, options: CallOptions) !UpdateIncidentRecordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-incidents", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIncidentRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-incidents", "SSM Incidents", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/updateIncidentRecord";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;
    if (input.chat_channel) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"chatChannel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.impact) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"impact\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.notification_targets) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"notificationTargets\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.summary) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"summary\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.title) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"title\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIncidentRecordOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateIncidentRecordOutput = .{};

    return result;
}
