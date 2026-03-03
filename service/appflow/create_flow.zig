const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DestinationFlowConfig = @import("destination_flow_config.zig").DestinationFlowConfig;
const MetadataCatalogConfig = @import("metadata_catalog_config.zig").MetadataCatalogConfig;
const SourceFlowConfig = @import("source_flow_config.zig").SourceFlowConfig;
const Task = @import("task.zig").Task;
const TriggerConfig = @import("trigger_config.zig").TriggerConfig;
const FlowStatus = @import("flow_status.zig").FlowStatus;

pub const CreateFlowInput = struct {
    /// The `clientToken` parameter is an idempotency token. It ensures that your
    /// `CreateFlow` request completes only once. You choose the value to pass. For
    /// example, if you don't receive a response from your request, you can safely
    /// retry the request
    /// with the same `clientToken` parameter value.
    ///
    /// If you omit a `clientToken` value, the Amazon Web Services SDK that you are
    /// using inserts a value for you. This way, the SDK can safely retry requests
    /// multiple times
    /// after a network error. You must provide your own value for other use cases.
    ///
    /// If you specify input parameters that differ from your first request, an
    /// error occurs. If
    /// you use a different value for `clientToken`, Amazon AppFlow considers it a
    /// new
    /// call to `CreateFlow`. The token is active for 8 hours.
    client_token: ?[]const u8 = null,

    /// A description of the flow you want to create.
    description: ?[]const u8 = null,

    /// The configuration that controls how Amazon AppFlow places data in the
    /// destination
    /// connector.
    destination_flow_config_list: []const DestinationFlowConfig,

    /// The specified name of the flow. Spaces are not allowed. Use underscores (_)
    /// or hyphens
    /// (-) only.
    flow_name: []const u8,

    /// The ARN (Amazon Resource Name) of the Key Management Service (KMS) key you
    /// provide for
    /// encryption. This is required if you do not want to use the Amazon
    /// AppFlow-managed KMS
    /// key. If you don't provide anything here, Amazon AppFlow uses the Amazon
    /// AppFlow-managed KMS key.
    kms_arn: ?[]const u8 = null,

    /// Specifies the configuration that Amazon AppFlow uses when it catalogs the
    /// data that's
    /// transferred by the associated flow. When Amazon AppFlow catalogs the data
    /// from a flow, it
    /// stores metadata in a data catalog.
    metadata_catalog_config: ?MetadataCatalogConfig = null,

    /// The configuration that controls how Amazon AppFlow retrieves data from the
    /// source
    /// connector.
    source_flow_config: SourceFlowConfig,

    /// The tags used to organize, track, or control access for your flow.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A list of tasks that Amazon AppFlow performs while transferring the data in
    /// the flow
    /// run.
    tasks: []const Task,

    /// The trigger settings that determine how and when the flow runs.
    trigger_config: TriggerConfig,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .destination_flow_config_list = "destinationFlowConfigList",
        .flow_name = "flowName",
        .kms_arn = "kmsArn",
        .metadata_catalog_config = "metadataCatalogConfig",
        .source_flow_config = "sourceFlowConfig",
        .tags = "tags",
        .tasks = "tasks",
        .trigger_config = "triggerConfig",
    };
};

pub const CreateFlowOutput = struct {
    /// The flow's Amazon Resource Name (ARN).
    flow_arn: ?[]const u8 = null,

    /// Indicates the current status of the flow.
    flow_status: ?FlowStatus = null,

    pub const json_field_names = .{
        .flow_arn = "flowArn",
        .flow_status = "flowStatus",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFlowInput, options: Options) !CreateFlowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appflow");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/create-flow";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationFlowConfigList\":");
    try aws.json.writeValue(@TypeOf(input.destination_flow_config_list), input.destination_flow_config_list, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"flowName\":");
    try aws.json.writeValue(@TypeOf(input.flow_name), input.flow_name, allocator, &body_buf);
    has_prev = true;
    if (input.kms_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata_catalog_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadataCatalogConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceFlowConfig\":");
    try aws.json.writeValue(@TypeOf(input.source_flow_config), input.source_flow_config, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"tasks\":");
    try aws.json.writeValue(@TypeOf(input.tasks), input.tasks, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"triggerConfig\":");
    try aws.json.writeValue(@TypeOf(input.trigger_config), input.trigger_config, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFlowOutput {
    var result: CreateFlowOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateFlowOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConnectorAuthenticationException")) {
        return .{ .arena = arena, .kind = .{ .connector_authentication_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConnectorServerException")) {
        return .{ .arena = arena, .kind = .{ .connector_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
