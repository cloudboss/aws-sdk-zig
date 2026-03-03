const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ConnectorType = @import("connector_type.zig").ConnectorType;

pub const ResetConnectorMetadataCacheInput = struct {
    /// The API version that you specified in the connector profile that you’re
    /// resetting cached
    /// metadata for. You must use this parameter only if the connector supports
    /// multiple API versions
    /// or if the connector type is CustomConnector.
    ///
    /// To look up how many versions a connector supports, use the
    /// DescribeConnectors action. In
    /// the response, find the value that Amazon AppFlow returns for the
    /// connectorVersion
    /// parameter.
    ///
    /// To look up the connector type, use the DescribeConnectorProfiles action. In
    /// the response,
    /// find the value that Amazon AppFlow returns for the connectorType parameter.
    ///
    /// To look up the API version that you specified in a connector profile, use
    /// the
    /// DescribeConnectorProfiles action.
    api_version: ?[]const u8 = null,

    /// Use this parameter if you want to reset cached metadata about the details
    /// for an
    /// individual entity.
    ///
    /// If you don't include this parameter in your request, Amazon AppFlow only
    /// resets
    /// cached metadata about entity names, not entity details.
    connector_entity_name: ?[]const u8 = null,

    /// The name of the connector profile that you want to reset cached metadata
    /// for.
    ///
    /// You can omit this parameter if you're resetting the cache for any of the
    /// following
    /// connectors: Amazon Connect, Amazon EventBridge, Amazon Lookout for Metrics,
    /// Amazon S3, or Upsolver. If you're resetting the cache for any other
    /// connector, you must include this
    /// parameter in your request.
    connector_profile_name: ?[]const u8 = null,

    /// The type of connector to reset cached metadata for.
    ///
    /// You must include this parameter in your request if you're resetting the
    /// cache for any of
    /// the following connectors: Amazon Connect, Amazon EventBridge, Amazon Lookout
    /// for Metrics,
    /// Amazon S3, or Upsolver. If you're resetting the cache for any other
    /// connector, you
    /// can omit this parameter from your request.
    connector_type: ?ConnectorType = null,

    /// Use this parameter only if you’re resetting the cached metadata about a
    /// nested entity.
    /// Only some connectors support nested entities. A nested entity is one that
    /// has another entity
    /// as a parent. To use this parameter, specify the name of the parent entity.
    ///
    /// To look up the parent-child relationship of entities, you can send a
    /// ListConnectorEntities
    /// request that omits the entitiesPath parameter. Amazon AppFlow will return a
    /// list of
    /// top-level entities. For each one, it indicates whether the entity has nested
    /// entities. Then,
    /// in a subsequent ListConnectorEntities request, you can specify a parent
    /// entity name for the
    /// entitiesPath parameter. Amazon AppFlow will return a list of the child
    /// entities for that
    /// parent.
    entities_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_version = "apiVersion",
        .connector_entity_name = "connectorEntityName",
        .connector_profile_name = "connectorProfileName",
        .connector_type = "connectorType",
        .entities_path = "entitiesPath",
    };
};

pub const ResetConnectorMetadataCacheOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ResetConnectorMetadataCacheInput, options: CallOptions) !ResetConnectorMetadataCacheOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ResetConnectorMetadataCacheInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/reset-connector-metadata-cache";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.api_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"apiVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_entity_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorEntityName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_profile_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorProfileName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.entities_path) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"entitiesPath\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ResetConnectorMetadataCacheOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: ResetConnectorMetadataCacheOutput = .{};

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
