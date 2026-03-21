const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DomainInformation = @import("domain_information.zig").DomainInformation;
const OutboundCrossClusterSearchConnectionStatus = @import("outbound_cross_cluster_search_connection_status.zig").OutboundCrossClusterSearchConnectionStatus;

pub const CreateOutboundCrossClusterSearchConnectionInput = struct {
    /// Specifies the connection alias that will be used by the customer for this
    /// connection.
    connection_alias: []const u8,

    /// Specifies the `DomainInformation` for the destination Elasticsearch domain.
    destination_domain_info: DomainInformation,

    /// Specifies the `DomainInformation` for the source Elasticsearch domain.
    source_domain_info: DomainInformation,

    pub const json_field_names = .{
        .connection_alias = "ConnectionAlias",
        .destination_domain_info = "DestinationDomainInfo",
        .source_domain_info = "SourceDomainInfo",
    };
};

pub const CreateOutboundCrossClusterSearchConnectionOutput = struct {
    /// Specifies the connection alias provided during the create connection
    /// request.
    connection_alias: ?[]const u8 = null,

    /// Specifies the `OutboundCrossClusterSearchConnectionStatus` for the newly
    /// created connection.
    connection_status: ?OutboundCrossClusterSearchConnectionStatus = null,

    /// Unique id for the created outbound connection, which is used for subsequent
    /// operations on connection.
    cross_cluster_search_connection_id: ?[]const u8 = null,

    /// Specifies the `DomainInformation` for the destination Elasticsearch domain.
    destination_domain_info: ?DomainInformation = null,

    /// Specifies the `DomainInformation` for the source Elasticsearch domain.
    source_domain_info: ?DomainInformation = null,

    pub const json_field_names = .{
        .connection_alias = "ConnectionAlias",
        .connection_status = "ConnectionStatus",
        .cross_cluster_search_connection_id = "CrossClusterSearchConnectionId",
        .destination_domain_info = "DestinationDomainInfo",
        .source_domain_info = "SourceDomainInfo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOutboundCrossClusterSearchConnectionInput, options: CallOptions) !CreateOutboundCrossClusterSearchConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "es");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOutboundCrossClusterSearchConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/2015-01-01/es/ccs/outboundConnection";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConnectionAlias\":");
    try aws.json.writeValue(@TypeOf(input.connection_alias), input.connection_alias, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DestinationDomainInfo\":");
    try aws.json.writeValue(@TypeOf(input.destination_domain_info), input.destination_domain_info, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SourceDomainInfo\":");
    try aws.json.writeValue(@TypeOf(input.source_domain_info), input.source_domain_info, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOutboundCrossClusterSearchConnectionOutput {
    var result: CreateOutboundCrossClusterSearchConnectionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateOutboundCrossClusterSearchConnectionOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "BaseException")) {
        return .{ .arena = arena, .kind = .{ .base_exception = .{
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
    if (std.mem.eql(u8, error_code, "DisabledOperationException")) {
        return .{ .arena = arena, .kind = .{ .disabled_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPaginationTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_pagination_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTypeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
