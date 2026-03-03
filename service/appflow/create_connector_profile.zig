const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConnectionMode = @import("connection_mode.zig").ConnectionMode;
const ConnectorProfileConfig = @import("connector_profile_config.zig").ConnectorProfileConfig;
const ConnectorType = @import("connector_type.zig").ConnectorType;

pub const CreateConnectorProfileInput = struct {
    /// The `clientToken` parameter is an idempotency token. It ensures that your
    /// `CreateConnectorProfile` request completes only once. You choose the value
    /// to
    /// pass. For example, if you don't receive a response from your request, you
    /// can safely retry the
    /// request with the same `clientToken` parameter value.
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
    /// call to `CreateConnectorProfile`. The token is active for 8 hours.
    client_token: ?[]const u8 = null,

    /// Indicates the connection mode and specifies whether it is public or private.
    /// Private
    /// flows use Amazon Web Services PrivateLink to route data over Amazon Web
    /// Services infrastructure
    /// without exposing it to the public internet.
    connection_mode: ConnectionMode,

    /// The label of the connector. The label is unique for each
    /// `ConnectorRegistration` in your Amazon Web Services account. Only needed if
    /// calling for CUSTOMCONNECTOR connector type/.
    connector_label: ?[]const u8 = null,

    /// Defines the connector-specific configuration and credentials.
    connector_profile_config: ConnectorProfileConfig,

    /// The name of the connector profile. The name is unique for each
    /// `ConnectorProfile` in your Amazon Web Services account.
    connector_profile_name: []const u8,

    /// The type of connector, such as Salesforce, Amplitude, and so on.
    connector_type: ConnectorType,

    /// The ARN (Amazon Resource Name) of the Key Management Service (KMS) key you
    /// provide for
    /// encryption. This is required if you do not want to use the Amazon
    /// AppFlow-managed KMS
    /// key. If you don't provide anything here, Amazon AppFlow uses the Amazon
    /// AppFlow-managed KMS key.
    kms_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .connection_mode = "connectionMode",
        .connector_label = "connectorLabel",
        .connector_profile_config = "connectorProfileConfig",
        .connector_profile_name = "connectorProfileName",
        .connector_type = "connectorType",
        .kms_arn = "kmsArn",
    };
};

pub const CreateConnectorProfileOutput = struct {
    /// The Amazon Resource Name (ARN) of the connector profile.
    connector_profile_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_profile_arn = "connectorProfileArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectorProfileInput, options: Options) !CreateConnectorProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectorProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/create-connector-profile";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"connectionMode\":");
    try aws.json.writeValue(@TypeOf(input.connection_mode), input.connection_mode, allocator, &body_buf);
    has_prev = true;
    if (input.connector_label) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorLabel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"connectorProfileConfig\":");
    try aws.json.writeValue(@TypeOf(input.connector_profile_config), input.connector_profile_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"connectorProfileName\":");
    try aws.json.writeValue(@TypeOf(input.connector_profile_name), input.connector_profile_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"connectorType\":");
    try aws.json.writeValue(@TypeOf(input.connector_type), input.connector_type, allocator, &body_buf);
    has_prev = true;
    if (input.kms_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectorProfileOutput {
    var result: CreateConnectorProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConnectorProfileOutput, body, allocator);
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
