const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FlowDefinition = @import("flow_definition.zig").FlowDefinition;
const Scope = @import("scope.zig").Scope;

pub const PutIntegrationInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// A list of unique names for active event triggers associated with the
    /// integration.
    event_trigger_names: ?[]const []const u8 = null,

    /// The configuration that controls how Customer Profiles retrieves data from
    /// the
    /// source.
    flow_definition: ?FlowDefinition = null,

    /// The name of the profile object type.
    object_type_name: ?[]const u8 = null,

    /// A map in which each key is an event type from an external application such
    /// as Segment or Shopify, and each value is an `ObjectTypeName` (template) used
    /// to ingest the event.
    /// It supports the following event types: `SegmentIdentify`,
    /// `ShopifyCreateCustomers`, `ShopifyUpdateCustomers`,
    /// `ShopifyCreateDraftOrders`,
    /// `ShopifyUpdateDraftOrders`, `ShopifyCreateOrders`, and
    /// `ShopifyUpdatedOrders`.
    object_type_names: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the IAM role. The Integration uses this
    /// role to make
    /// Customer Profiles requests on your behalf.
    role_arn: ?[]const u8 = null,

    /// Specifies whether the integration applies to profile level data (associated
    /// with profiles) or domain level data (not associated with any specific
    /// profile). The default value is PROFILE.
    scope: ?Scope = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The URI of the S3 bucket or any other type of data source.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .event_trigger_names = "EventTriggerNames",
        .flow_definition = "FlowDefinition",
        .object_type_name = "ObjectTypeName",
        .object_type_names = "ObjectTypeNames",
        .role_arn = "RoleArn",
        .scope = "Scope",
        .tags = "Tags",
        .uri = "Uri",
    };
};

pub const PutIntegrationOutput = struct {
    /// The timestamp of when the domain was created.
    created_at: i64,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// A list of unique names for active event triggers associated with the
    /// integration. This
    /// list would be empty if no Event Trigger is associated with the integration.
    event_trigger_names: ?[]const []const u8 = null,

    /// Boolean that shows if the Flow that's associated with the Integration is
    /// created in
    /// Amazon Appflow, or with ObjectTypeName equals _unstructured via API/CLI in
    /// flowDefinition.
    is_unstructured: ?bool = null,

    /// The timestamp of when the domain was most recently edited.
    last_updated_at: i64,

    /// The name of the profile object type.
    object_type_name: ?[]const u8 = null,

    /// A map in which each key is an event type from an external application such
    /// as Segment or Shopify, and each value is an `ObjectTypeName` (template) used
    /// to ingest the event.
    /// It supports the following event types: `SegmentIdentify`,
    /// `ShopifyCreateCustomers`, `ShopifyUpdateCustomers`,
    /// `ShopifyCreateDraftOrders`,
    /// `ShopifyUpdateDraftOrders`, `ShopifyCreateOrders`, and
    /// `ShopifyUpdatedOrders`.
    object_type_names: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the IAM role. The Integration uses this
    /// role to make
    /// Customer Profiles requests on your behalf.
    role_arn: ?[]const u8 = null,

    /// Specifies whether the integration applies to profile level data (associated
    /// with profiles) or domain level data (not associated with any specific
    /// profile). The default value is PROFILE.
    scope: ?Scope = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The URI of the S3 bucket or any other type of data source.
    uri: []const u8,

    /// Unique identifier for the workflow.
    workflow_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .domain_name = "DomainName",
        .event_trigger_names = "EventTriggerNames",
        .is_unstructured = "IsUnstructured",
        .last_updated_at = "LastUpdatedAt",
        .object_type_name = "ObjectTypeName",
        .object_type_names = "ObjectTypeNames",
        .role_arn = "RoleArn",
        .scope = "Scope",
        .tags = "Tags",
        .uri = "Uri",
        .workflow_id = "WorkflowId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutIntegrationInput, options: CallOptions) !PutIntegrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "profile");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: PutIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/integrations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.event_trigger_names) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EventTriggerNames\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.flow_definition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FlowDefinition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.object_type_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ObjectTypeName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.object_type_names) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ObjectTypeNames\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scope) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Scope\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Uri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutIntegrationOutput {
    var result: PutIntegrationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutIntegrationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
