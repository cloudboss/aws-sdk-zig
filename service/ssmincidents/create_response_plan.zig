const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Action = @import("action.zig").Action;
const ChatChannel = @import("chat_channel.zig").ChatChannel;
const IncidentTemplate = @import("incident_template.zig").IncidentTemplate;
const Integration = @import("integration.zig").Integration;

pub const CreateResponsePlanInput = struct {
    /// The actions that the response plan starts at the beginning of an incident.
    actions: ?[]const Action = null,

    /// The Chatbot chat channel used for collaboration during an incident.
    chat_channel: ?ChatChannel = null,

    /// A token ensuring that the operation is called only once with the specified
    /// details.
    client_token: ?[]const u8 = null,

    /// The long format of the response plan name. This field can contain spaces.
    display_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the contacts and escalation plans that
    /// the response
    /// plan engages during an incident.
    engagements: ?[]const []const u8 = null,

    /// Details used to create an incident when using this response plan.
    incident_template: IncidentTemplate,

    /// Information about third-party services integrated into the response plan.
    integrations: ?[]const Integration = null,

    /// The short format name of the response plan. Can't include spaces.
    name: []const u8,

    /// A list of tags that you are adding to the response plan.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .actions = "actions",
        .chat_channel = "chatChannel",
        .client_token = "clientToken",
        .display_name = "displayName",
        .engagements = "engagements",
        .incident_template = "incidentTemplate",
        .integrations = "integrations",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateResponsePlanOutput = struct {
    /// The Amazon Resource Name (ARN) of the response plan.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResponsePlanInput, options: CallOptions) !CreateResponsePlanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResponsePlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-incidents", "SSM Incidents", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/createResponsePlan";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.actions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"actions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"incidentTemplate\":");
    try aws.json.writeValue(@TypeOf(input.incident_template), input.incident_template, allocator, &body_buf);
    has_prev = true;
    if (input.integrations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"integrations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResponsePlanOutput {
    const result: CreateResponsePlanOutput = try aws.json.parseJsonObject(
        CreateResponsePlanOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
