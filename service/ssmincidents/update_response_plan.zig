const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Action = @import("action.zig").Action;
const ChatChannel = @import("chat_channel.zig").ChatChannel;
const NotificationTargetItem = @import("notification_target_item.zig").NotificationTargetItem;
const Integration = @import("integration.zig").Integration;

pub const UpdateResponsePlanInput = struct {
    /// The actions that this response plan takes at the beginning of an incident.
    actions: ?[]const Action = null,

    /// The Amazon Resource Name (ARN) of the response plan.
    arn: []const u8,

    /// The Chatbot chat channel used for collaboration during an incident.
    ///
    /// Use the empty structure to remove the chat channel from the response plan.
    chat_channel: ?ChatChannel = null,

    /// A token ensuring that the operation is called only once with the specified
    /// details.
    client_token: ?[]const u8 = null,

    /// The long format name of the response plan. The display name can't contain
    /// spaces.
    display_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the contacts and escalation plans that
    /// the response
    /// plan engages during an incident.
    engagements: ?[]const []const u8 = null,

    /// The string Incident Manager uses to prevent duplicate incidents from being
    /// created by the same
    /// incident in the same account.
    incident_template_dedupe_string: ?[]const u8 = null,

    /// Defines the impact to the customers. Providing an impact overwrites the
    /// impact provided by
    /// a response plan.
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
    incident_template_impact: ?i32 = null,

    /// The Amazon SNS targets that are notified when updates are made to an
    /// incident.
    incident_template_notification_targets: ?[]const NotificationTargetItem = null,

    /// A brief summary of the incident. This typically contains what has happened,
    /// what's
    /// currently happening, and next steps.
    incident_template_summary: ?[]const u8 = null,

    /// Tags to assign to the template. When the `StartIncident` API action is
    /// called,
    /// Incident Manager assigns the tags specified in the template to the incident.
    /// To call this action,
    /// you must also have permission to call the `TagResource` API action for the
    /// incident
    /// record resource.
    incident_template_tags: ?[]const aws.map.StringMapEntry = null,

    /// The short format name of the incident. The title can't contain spaces.
    incident_template_title: ?[]const u8 = null,

    /// Information about third-party services integrated into the response plan.
    integrations: ?[]const Integration = null,

    pub const json_field_names = .{
        .actions = "actions",
        .arn = "arn",
        .chat_channel = "chatChannel",
        .client_token = "clientToken",
        .display_name = "displayName",
        .engagements = "engagements",
        .incident_template_dedupe_string = "incidentTemplateDedupeString",
        .incident_template_impact = "incidentTemplateImpact",
        .incident_template_notification_targets = "incidentTemplateNotificationTargets",
        .incident_template_summary = "incidentTemplateSummary",
        .incident_template_tags = "incidentTemplateTags",
        .incident_template_title = "incidentTemplateTitle",
        .integrations = "integrations",
    };
};

pub const UpdateResponsePlanOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateResponsePlanInput, options: CallOptions) !UpdateResponsePlanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateResponsePlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-incidents", "SSM Incidents", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/updateResponsePlan";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.actions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"actions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.engagements) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"engagements\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.incident_template_dedupe_string) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"incidentTemplateDedupeString\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.incident_template_impact) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"incidentTemplateImpact\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.incident_template_notification_targets) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"incidentTemplateNotificationTargets\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.incident_template_summary) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"incidentTemplateSummary\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.incident_template_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"incidentTemplateTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.incident_template_title) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"incidentTemplateTitle\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.integrations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"integrations\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateResponsePlanOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateResponsePlanOutput = .{};

    return result;
}
