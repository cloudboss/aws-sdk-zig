const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IncomingKeyMaterial = @import("incoming_key_material.zig").IncomingKeyMaterial;
const KeyCheckValueAlgorithm = @import("key_check_value_algorithm.zig").KeyCheckValueAlgorithm;
const OutgoingKeyMaterial = @import("outgoing_key_material.zig").OutgoingKeyMaterial;
const WrappedWorkingKey = @import("wrapped_working_key.zig").WrappedWorkingKey;

pub const TranslateKeyMaterialInput = struct {
    /// Parameter information of the TR31WrappedKeyBlock containing the transaction
    /// key.
    incoming_key_material: IncomingKeyMaterial,

    /// The key check value (KCV) algorithm used for calculating the KCV of the
    /// derived key.
    key_check_value_algorithm: ?KeyCheckValueAlgorithm = null,

    /// Parameter information of the wrapping key used to wrap the transaction key
    /// in the outgoing TR31WrappedKeyBlock.
    outgoing_key_material: OutgoingKeyMaterial,

    pub const json_field_names = .{
        .incoming_key_material = "IncomingKeyMaterial",
        .key_check_value_algorithm = "KeyCheckValueAlgorithm",
        .outgoing_key_material = "OutgoingKeyMaterial",
    };
};

pub const TranslateKeyMaterialOutput = struct {
    /// The outgoing KEK wrapped TR31WrappedKeyBlock.
    wrapped_key: ?WrappedWorkingKey = null,

    pub const json_field_names = .{
        .wrapped_key = "WrappedKey",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TranslateKeyMaterialInput, options: Options) !TranslateKeyMaterialOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "paymentcryptographydata");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: TranslateKeyMaterialInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("paymentcryptographydata", "Payment Cryptography Data", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/keymaterial/translate";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"IncomingKeyMaterial\":");
    try aws.json.writeValue(@TypeOf(input.incoming_key_material), input.incoming_key_material, alloc, &body_buf);
    has_prev = true;
    if (input.key_check_value_algorithm) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"KeyCheckValueAlgorithm\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"OutgoingKeyMaterial\":");
    try aws.json.writeValue(@TypeOf(input.outgoing_key_material), input.outgoing_key_material, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !TranslateKeyMaterialOutput {
    var result: TranslateKeyMaterialOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(TranslateKeyMaterialOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VerificationFailedException")) {
        return .{ .arena = arena, .kind = .{ .verification_failed_exception = .{
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
