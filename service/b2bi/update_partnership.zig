const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CapabilityOptions = @import("capability_options.zig").CapabilityOptions;

pub const UpdatePartnershipInput = struct {
    /// List of the capabilities associated with this partnership.
    capabilities: ?[]const []const u8 = null,

    /// To update, specify the structure that contains the details for the
    /// associated capabilities.
    capability_options: ?CapabilityOptions = null,

    /// The name of the partnership, used to identify it.
    name: ?[]const u8 = null,

    /// Specifies the unique, system-generated identifier for a partnership.
    partnership_id: []const u8,

    pub const json_field_names = .{
        .capabilities = "capabilities",
        .capability_options = "capabilityOptions",
        .name = "name",
        .partnership_id = "partnershipId",
    };
};

pub const UpdatePartnershipOutput = struct {
    /// Returns one or more capabilities associated with this partnership.
    capabilities: ?[]const []const u8 = null,

    /// Returns the structure that contains the details for the associated
    /// capabilities.
    capability_options: ?CapabilityOptions = null,

    /// Returns a timestamp that identifies the most recent date and time that the
    /// partnership was modified.
    created_at: i64,

    /// Returns the email address associated with this trading partner.
    email: ?[]const u8 = null,

    /// Returns a timestamp that identifies the most recent date and time that the
    /// partnership was modified.
    modified_at: ?i64 = null,

    /// The name of the partnership, used to identify it.
    name: ?[]const u8 = null,

    /// Returns an Amazon Resource Name (ARN) for a specific Amazon Web Services
    /// resource, such as a capability, partnership, profile, or transformer.
    partnership_arn: []const u8,

    /// Returns the unique, system-generated identifier for a partnership.
    partnership_id: []const u8,

    /// Returns the phone number associated with the partnership.
    phone: ?[]const u8 = null,

    /// Returns the unique, system-generated identifier for the profile connected to
    /// this partnership.
    profile_id: []const u8,

    /// Returns the unique, system-generated identifier for a trading partner.
    trading_partner_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .capabilities = "capabilities",
        .capability_options = "capabilityOptions",
        .created_at = "createdAt",
        .email = "email",
        .modified_at = "modifiedAt",
        .name = "name",
        .partnership_arn = "partnershipArn",
        .partnership_id = "partnershipId",
        .phone = "phone",
        .profile_id = "profileId",
        .trading_partner_id = "tradingPartnerId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePartnershipInput, options: CallOptions) !UpdatePartnershipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "b2bi");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePartnershipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("b2bi", "b2bi", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "B2BI.UpdatePartnership");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePartnershipOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdatePartnershipOutput, body, allocator);
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
