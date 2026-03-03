const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConditionOverrides = @import("condition_overrides.zig").ConditionOverrides;
const CalculatedAttributeValue = @import("calculated_attribute_value.zig").CalculatedAttributeValue;
const BatchGetCalculatedAttributeForProfileError = @import("batch_get_calculated_attribute_for_profile_error.zig").BatchGetCalculatedAttributeForProfileError;

pub const BatchGetCalculatedAttributeForProfileInput = struct {
    /// The unique name of the calculated attribute.
    calculated_attribute_name: []const u8,

    /// Overrides the condition block within the original calculated attribute
    /// definition.
    condition_overrides: ?ConditionOverrides = null,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// List of unique identifiers for customer profiles to retrieve.
    profile_ids: []const []const u8,

    pub const json_field_names = .{
        .calculated_attribute_name = "CalculatedAttributeName",
        .condition_overrides = "ConditionOverrides",
        .domain_name = "DomainName",
        .profile_ids = "ProfileIds",
    };
};

pub const BatchGetCalculatedAttributeForProfileOutput = struct {
    /// List of calculated attribute values retrieved.
    calculated_attribute_values: ?[]const CalculatedAttributeValue = null,

    /// Overrides the condition block within the original calculated attribute
    /// definition.
    condition_overrides: ?ConditionOverrides = null,

    /// List of errors for calculated attribute values that could not be retrieved.
    errors: ?[]const BatchGetCalculatedAttributeForProfileError = null,

    pub const json_field_names = .{
        .calculated_attribute_values = "CalculatedAttributeValues",
        .condition_overrides = "ConditionOverrides",
        .errors = "Errors",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetCalculatedAttributeForProfileInput, options: Options) !BatchGetCalculatedAttributeForProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "customerprofiles");

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetCalculatedAttributeForProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("customerprofiles", "Customer Profiles", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/calculated-attributes/");
    try path_buf.appendSlice(allocator, input.calculated_attribute_name);
    try path_buf.appendSlice(allocator, "/batch-get-for-profiles");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.condition_overrides) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConditionOverrides\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ProfileIds\":");
    try aws.json.writeValue(@TypeOf(input.profile_ids), input.profile_ids, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetCalculatedAttributeForProfileOutput {
    var result: BatchGetCalculatedAttributeForProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetCalculatedAttributeForProfileOutput, body, allocator);
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
