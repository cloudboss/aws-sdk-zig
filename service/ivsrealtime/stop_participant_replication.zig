const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const StopParticipantReplicationInput = struct {
    /// ARN of the stage where the participant has been replicated.
    destination_stage_arn: []const u8,

    /// Participant ID of the publisher that has been replicated. This is assigned
    /// by IVS and returned by
    /// CreateParticipantToken
    /// or the `jti` (JWT ID) used to [
    /// create a self signed
    /// token](https://docs.aws.amazon.com/ivs/latest/RealTimeUserGuide/getting-started-distribute-tokens.html#getting-started-distribute-tokens-self-signed).
    participant_id: []const u8,

    /// ARN of the stage where the participant is publishing.
    source_stage_arn: []const u8,

    pub const json_field_names = .{
        .destination_stage_arn = "destinationStageArn",
        .participant_id = "participantId",
        .source_stage_arn = "sourceStageArn",
    };
};

pub const StopParticipantReplicationOutput = struct {
    access_control_allow_origin: ?[]const u8 = null,

    access_control_expose_headers: ?[]const u8 = null,

    cache_control: ?[]const u8 = null,

    content_security_policy: ?[]const u8 = null,

    strict_transport_security: ?[]const u8 = null,

    x_content_type_options: ?[]const u8 = null,

    x_frame_options: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_control_allow_origin = "accessControlAllowOrigin",
        .access_control_expose_headers = "accessControlExposeHeaders",
        .cache_control = "cacheControl",
        .content_security_policy = "contentSecurityPolicy",
        .strict_transport_security = "strictTransportSecurity",
        .x_content_type_options = "xContentTypeOptions",
        .x_frame_options = "xFrameOptions",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopParticipantReplicationInput, options: Options) !StopParticipantReplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ivsrealtime");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StopParticipantReplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivsrealtime", "IVS RealTime", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/StopParticipantReplication";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationStageArn\":");
    try aws.json.writeValue(@TypeOf(input.destination_stage_arn), input.destination_stage_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"participantId\":");
    try aws.json.writeValue(@TypeOf(input.participant_id), input.participant_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceStageArn\":");
    try aws.json.writeValue(@TypeOf(input.source_stage_arn), input.source_stage_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopParticipantReplicationOutput {
    var result: StopParticipantReplicationOutput = .{};
    _ = body;
    _ = status;
    if (headers.get("access-control-allow-origin")) |value| {
        result.access_control_allow_origin = try allocator.dupe(u8, value);
    }
    if (headers.get("access-control-expose-headers")) |value| {
        result.access_control_expose_headers = try allocator.dupe(u8, value);
    }
    if (headers.get("cache-control")) |value| {
        result.cache_control = try allocator.dupe(u8, value);
    }
    if (headers.get("content-security-policy")) |value| {
        result.content_security_policy = try allocator.dupe(u8, value);
    }
    if (headers.get("strict-transport-security")) |value| {
        result.strict_transport_security = try allocator.dupe(u8, value);
    }
    if (headers.get("x-content-type-options")) |value| {
        result.x_content_type_options = try allocator.dupe(u8, value);
    }
    if (headers.get("x-frame-options")) |value| {
        result.x_frame_options = try allocator.dupe(u8, value);
    }

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
    if (std.mem.eql(u8, error_code, "PendingVerification")) {
        return .{ .arena = arena, .kind = .{ .pending_verification = .{
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
