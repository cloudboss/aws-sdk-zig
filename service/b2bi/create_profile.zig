const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Logging = @import("logging.zig").Logging;
const Tag = @import("tag.zig").Tag;

pub const CreateProfileInput = struct {
    /// Specifies the name for the business associated with this profile.
    business_name: []const u8,

    /// Reserved for future use.
    client_token: ?[]const u8 = null,

    /// Specifies the email address associated with this customer profile.
    email: ?[]const u8 = null,

    /// Specifies whether or not logging is enabled for this profile.
    logging: Logging,

    /// Specifies the name of the profile.
    name: []const u8,

    /// Specifies the phone number associated with the profile.
    phone: []const u8,

    /// Specifies the key-value pairs assigned to ARNs that you can use to group and
    /// search for resources by type. You can attach this metadata to resources
    /// (capabilities, partnerships, and so on) for any purpose.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .business_name = "businessName",
        .client_token = "clientToken",
        .email = "email",
        .logging = "logging",
        .name = "name",
        .phone = "phone",
        .tags = "tags",
    };
};

pub const CreateProfileOutput = struct {
    /// Returns the name for the business associated with this profile.
    business_name: []const u8,

    /// Returns a timestamp representing the time the profile was created.
    created_at: i64,

    /// Returns the email address associated with this customer profile.
    email: ?[]const u8 = null,

    /// Returns whether or not logging is turned on for this profile.
    logging: ?Logging = null,

    /// Returns the name of the logging group.
    log_group_name: ?[]const u8 = null,

    /// Returns the name of the profile, used to identify it.
    name: []const u8,

    /// Returns the phone number associated with the profile.
    phone: []const u8,

    /// Returns an Amazon Resource Name (ARN) for the profile.
    profile_arn: []const u8,

    /// Returns the unique, system-generated identifier for the profile.
    profile_id: []const u8,

    pub const json_field_names = .{
        .business_name = "businessName",
        .created_at = "createdAt",
        .email = "email",
        .logging = "logging",
        .log_group_name = "logGroupName",
        .name = "name",
        .phone = "phone",
        .profile_arn = "profileArn",
        .profile_id = "profileId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProfileInput, options: Options) !CreateProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "b2bi");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("b2bi", "b2bi", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "B2BI.CreateProfile");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateProfileOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateProfileOutput, body, alloc);
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
