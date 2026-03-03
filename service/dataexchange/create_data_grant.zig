const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const GrantDistributionScope = @import("grant_distribution_scope.zig").GrantDistributionScope;
const DataGrantAcceptanceState = @import("data_grant_acceptance_state.zig").DataGrantAcceptanceState;

pub const CreateDataGrantInput = struct {
    /// The description of the data grant.
    description: ?[]const u8 = null,

    /// The timestamp of when access to the associated data set ends.
    ends_at: ?i64 = null,

    /// The distribution scope of the data grant.
    grant_distribution_scope: GrantDistributionScope,

    /// The name of the data grant.
    name: []const u8,

    /// The Amazon Web Services account ID of the data grant receiver.
    receiver_principal: []const u8,

    /// The ID of the data set used to create the data grant.
    source_data_set_id: []const u8,

    /// The tags to add to the data grant. A tag is a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .ends_at = "EndsAt",
        .grant_distribution_scope = "GrantDistributionScope",
        .name = "Name",
        .receiver_principal = "ReceiverPrincipal",
        .source_data_set_id = "SourceDataSetId",
        .tags = "Tags",
    };
};

pub const CreateDataGrantOutput = struct {
    /// The acceptance state of the data grant.
    acceptance_state: DataGrantAcceptanceState,

    /// The timestamp of when the data grant was accepted.
    accepted_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the data grant.
    arn: []const u8,

    /// The timestamp of when the data grant was created.
    created_at: i64,

    /// The ID of the data set associated to the data grant.
    data_set_id: []const u8,

    /// The description of the data grant.
    description: ?[]const u8 = null,

    /// The timestamp of when access to the associated data set ends.
    ends_at: ?i64 = null,

    /// The distribution scope for the data grant.
    grant_distribution_scope: GrantDistributionScope,

    /// The ID of the data grant.
    id: []const u8,

    /// The name of the data grant.
    name: []const u8,

    /// The Amazon Web Services account ID of the data grant receiver.
    receiver_principal: []const u8,

    /// The Amazon Web Services account ID of the data grant sender.
    sender_principal: []const u8,

    /// The ID of the data set used to create the data grant.
    source_data_set_id: []const u8,

    /// The tags associated to the data grant. A tag is a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp of when the data grant was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .acceptance_state = "AcceptanceState",
        .accepted_at = "AcceptedAt",
        .arn = "Arn",
        .created_at = "CreatedAt",
        .data_set_id = "DataSetId",
        .description = "Description",
        .ends_at = "EndsAt",
        .grant_distribution_scope = "GrantDistributionScope",
        .id = "Id",
        .name = "Name",
        .receiver_principal = "ReceiverPrincipal",
        .sender_principal = "SenderPrincipal",
        .source_data_set_id = "SourceDataSetId",
        .tags = "Tags",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataGrantInput, options: CallOptions) !CreateDataGrantOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "dataexchange");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataGrantInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dataexchange", "DataExchange", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/data-grants";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ends_at) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EndsAt\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GrantDistributionScope\":");
    try aws.json.writeValue(@TypeOf(input.grant_distribution_scope), input.grant_distribution_scope, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ReceiverPrincipal\":");
    try aws.json.writeValue(@TypeOf(input.receiver_principal), input.receiver_principal, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SourceDataSetId\":");
    try aws.json.writeValue(@TypeOf(input.source_data_set_id), input.source_data_set_id, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataGrantOutput {
    var result: CreateDataGrantOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDataGrantOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ServiceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_limit_exceeded_exception = .{
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
