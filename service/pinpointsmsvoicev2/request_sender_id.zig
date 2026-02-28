const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MessageType = @import("message_type.zig").MessageType;
const Tag = @import("tag.zig").Tag;

pub const RequestSenderIdInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. If you don't specify a client token, a randomly generated
    /// token is used for the request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// By default this is set to false. When set to true the sender ID can't be
    /// deleted.
    deletion_protection_enabled: ?bool = null,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: []const u8,

    /// The type of message. Valid values are TRANSACTIONAL for messages that are
    /// critical or time-sensitive and PROMOTIONAL for messages that aren't critical
    /// or time-sensitive.
    message_types: ?[]const MessageType = null,

    /// The sender ID string to request.
    sender_id: []const u8,

    /// An array of tags (key and value pairs) to associate with the sender ID.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .iso_country_code = "IsoCountryCode",
        .message_types = "MessageTypes",
        .sender_id = "SenderId",
        .tags = "Tags",
    };
};

pub const RequestSenderIdOutput = struct {
    /// By default this is set to false. When set to true the sender ID can't be
    /// deleted.
    deletion_protection_enabled: ?bool = null,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: []const u8,

    /// The type of message. Valid values are TRANSACTIONAL for messages that are
    /// critical or time-sensitive and PROMOTIONAL for messages that aren't critical
    /// or time-sensitive.
    message_types: ?[]const MessageType = null,

    /// The monthly price, in US dollars, to lease the sender ID.
    monthly_leasing_price: []const u8,

    /// True if the sender ID is registered.
    registered: ?bool = null,

    /// The sender ID that was requested.
    sender_id: []const u8,

    /// The Amazon Resource Name (ARN) associated with the SenderId.
    sender_id_arn: []const u8,

    /// An array of tags (key and value pairs) to associate with the sender ID.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .iso_country_code = "IsoCountryCode",
        .message_types = "MessageTypes",
        .monthly_leasing_price = "MonthlyLeasingPrice",
        .registered = "Registered",
        .sender_id = "SenderId",
        .sender_id_arn = "SenderIdArn",
        .tags = "Tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RequestSenderIdInput, options: Options) !RequestSenderIdOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "pinpointsmsvoicev2");

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

fn serializeRequest(alloc: std.mem.Allocator, input: RequestSenderIdInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pinpointsmsvoicev2", "Pinpoint SMS Voice V2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "PinpointSMSVoiceV2.RequestSenderId");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RequestSenderIdOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RequestSenderIdOutput, body, alloc);
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
