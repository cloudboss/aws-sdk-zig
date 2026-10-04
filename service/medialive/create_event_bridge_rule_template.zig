const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventBridgeRuleTemplateTarget = @import("event_bridge_rule_template_target.zig").EventBridgeRuleTemplateTarget;
const EventBridgeRuleTemplateEventType = @import("event_bridge_rule_template_event_type.zig").EventBridgeRuleTemplateEventType;

pub const CreateEventBridgeRuleTemplateInput = struct {
    /// A resource's optional description.
    description: ?[]const u8 = null,

    event_targets: ?[]const EventBridgeRuleTemplateTarget = null,

    event_type: EventBridgeRuleTemplateEventType,

    /// An eventbridge rule template group's identifier. Can be either be its id or
    /// current name.
    group_identifier: []const u8,

    /// A resource's name. Names must be unique within the scope of a resource type
    /// in a specific region.
    name: []const u8,

    /// An ID that you assign to a create request. This ID ensures idempotency when
    /// creating resources.
    request_id: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .event_targets = "EventTargets",
        .event_type = "EventType",
        .group_identifier = "GroupIdentifier",
        .name = "Name",
        .request_id = "RequestId",
        .tags = "Tags",
    };
};

pub const CreateEventBridgeRuleTemplateOutput = struct {
    /// An eventbridge rule template's ARN (Amazon Resource Name)
    arn: ?[]const u8 = null,

    created_at: ?i64 = null,

    /// A resource's optional description.
    description: ?[]const u8 = null,

    event_targets: ?[]const EventBridgeRuleTemplateTarget = null,

    event_type: ?EventBridgeRuleTemplateEventType = null,

    /// An eventbridge rule template group's id. AWS provided template groups have
    /// ids that start with `aws-`
    group_id: ?[]const u8 = null,

    /// An eventbridge rule template's id. AWS provided templates have ids that
    /// start with `aws-`
    id: ?[]const u8 = null,

    modified_at: ?i64 = null,

    /// A resource's name. Names must be unique within the scope of a resource type
    /// in a specific region.
    name: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .event_targets = "EventTargets",
        .event_type = "EventType",
        .group_id = "GroupId",
        .id = "Id",
        .modified_at = "ModifiedAt",
        .name = "Name",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEventBridgeRuleTemplateInput, options: CallOptions) !CreateEventBridgeRuleTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEventBridgeRuleTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/prod/eventbridge-rule-templates";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.event_targets) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EventTargets\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EventType\":");
    try aws.json.writeValue(@TypeOf(input.event_type), input.event_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GroupIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.group_identifier), input.group_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.request_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequestId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEventBridgeRuleTemplateOutput {
    const result: CreateEventBridgeRuleTemplateOutput = try aws.json.parseJsonObject(
        CreateEventBridgeRuleTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
