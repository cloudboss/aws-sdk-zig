const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ChannelMembershipType = @import("channel_membership_type.zig").ChannelMembershipType;
const Identity = @import("identity.zig").Identity;

pub const CreateChannelMembershipInput = struct {
    /// The ARN of the channel to which you're adding users.
    channel_arn: []const u8,

    /// The ARN of the `AppInstanceUser` or `AppInstanceBot`
    /// that makes the API call.
    chime_bearer: []const u8,

    /// The `AppInstanceUserArn` of the member you want to add to the channel.
    member_arn: []const u8,

    /// The ID of the SubChannel in the request.
    ///
    /// Only required when creating membership in a SubChannel for a moderator in an
    /// elastic channel.
    sub_channel_id: ?[]const u8 = null,

    /// The membership type of a user, `DEFAULT` or `HIDDEN`. Default
    /// members are always returned as part of `ListChannelMemberships`. Hidden
    /// members
    /// are only returned if the type filter in `ListChannelMemberships` equals
    /// `HIDDEN`. Otherwise hidden members are not returned. This is only supported
    /// by moderators.
    @"type": ChannelMembershipType,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .chime_bearer = "ChimeBearer",
        .member_arn = "MemberArn",
        .sub_channel_id = "SubChannelId",
        .@"type" = "Type",
    };
};

pub const CreateChannelMembershipOutput = struct {
    /// The ARN of the channel.
    channel_arn: ?[]const u8 = null,

    /// The ARN and metadata of the member being added.
    member: ?Identity = null,

    /// The ID of the SubChannel in the response.
    sub_channel_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .member = "Member",
        .sub_channel_id = "SubChannelId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChannelMembershipInput, options: Options) !CreateChannelMembershipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "chimesdkmessaging");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateChannelMembershipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chimesdkmessaging", "Chime SDK Messaging", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/channels/");
    try path_buf.appendSlice(alloc, input.channel_arn);
    try path_buf.appendSlice(alloc, "/memberships");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"MemberArn\":");
    try aws.json.writeValue(@TypeOf(input.member_arn), input.member_arn, alloc, &body_buf);
    has_prev = true;
    if (input.sub_channel_id) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SubChannelId\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", alloc, &body_buf);
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
    try request.headers.put(alloc, "x-amz-chime-bearer", input.chime_bearer);

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateChannelMembershipOutput {
    var result: CreateChannelMembershipOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateChannelMembershipOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceFailureException")) {
        return .{ .arena = arena, .kind = .{ .service_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledClientException")) {
        return .{ .arena = arena, .kind = .{ .throttled_client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedClientException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_client_exception = .{
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
