const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MacAttributes = @import("mac_attributes.zig").MacAttributes;

pub const GenerateMacInput = struct {
    /// The attributes and data values to use for MAC generation within Amazon Web
    /// Services Payment Cryptography.
    generation_attributes: MacAttributes,

    /// The `keyARN` of the MAC generation encryption key.
    key_identifier: []const u8,

    /// The length of a MAC under generation.
    mac_length: ?i32 = null,

    /// The data for which a MAC is under generation. This value must be hexBinary.
    message_data: []const u8,

    pub const json_field_names = .{
        .generation_attributes = "GenerationAttributes",
        .key_identifier = "KeyIdentifier",
        .mac_length = "MacLength",
        .message_data = "MessageData",
    };
};

pub const GenerateMacOutput = struct {
    /// The `keyARN` of the encryption key that Amazon Web Services Payment
    /// Cryptography uses for MAC generation.
    key_arn: []const u8,

    /// The key check value (KCV) of the encryption key. The KCV is used to check if
    /// all parties holding a given key have the same key or to detect that a key
    /// has changed.
    ///
    /// Amazon Web Services Payment Cryptography computes the KCV according to the
    /// CMAC specification.
    key_check_value: []const u8,

    /// The MAC cryptogram generated within Amazon Web Services Payment
    /// Cryptography.
    mac: []const u8,

    pub const json_field_names = .{
        .key_arn = "KeyArn",
        .key_check_value = "KeyCheckValue",
        .mac = "Mac",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateMacInput, options: Options) !GenerateMacOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateMacInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("paymentcryptographydata", "Payment Cryptography Data", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/mac/generate";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GenerationAttributes\":");
    try aws.json.writeValue(@TypeOf(input.generation_attributes), input.generation_attributes, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"KeyIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.key_identifier), input.key_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.mac_length) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MacLength\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MessageData\":");
    try aws.json.writeValue(@TypeOf(input.message_data), input.message_data, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateMacOutput {
    var result: GenerateMacOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GenerateMacOutput, body, allocator);
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
