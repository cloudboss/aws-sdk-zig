const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RecurrenceSettings = @import("recurrence_settings.zig").RecurrenceSettings;
const Tag = @import("tag.zig").Tag;

pub const CreateRotationInput = struct {
    /// The Amazon Resource Names (ARNs) of the contacts to add to the rotation.
    ///
    /// Only the `PERSONAL` contact type is supported. The contact types
    /// `ESCALATION` and `ONCALL_SCHEDULE` are not supported for this
    /// operation.
    ///
    /// The order that you list the contacts in is their shift order in the rotation
    /// schedule.
    /// To change the order of the contact's shifts, use the UpdateRotation
    /// operation.
    contact_ids: []const []const u8,

    /// A token that ensures that the operation is called only once with the
    /// specified
    /// details.
    idempotency_token: ?[]const u8 = null,

    /// The name of the rotation.
    name: []const u8,

    /// Information about the rule that specifies when a shift's team members
    /// rotate.
    recurrence: RecurrenceSettings,

    /// The date and time that the rotation goes into effect.
    start_time: ?i64 = null,

    /// Optional metadata to assign to the rotation. Tags enable you to categorize a
    /// resource in
    /// different ways, such as by purpose, owner, or environment. For more
    /// information, see [Tagging
    /// Incident Manager
    /// resources](https://docs.aws.amazon.com/incident-manager/latest/userguide/tagging.html) in the *Incident Manager User
    /// Guide*.
    tags: ?[]const Tag = null,

    /// The time zone to base the rotation’s activity on in Internet Assigned
    /// Numbers Authority
    /// (IANA) format. For example: "America/Los_Angeles", "UTC", or "Asia/Seoul".
    /// For more
    /// information, see the [Time Zone
    /// Database](https://www.iana.org/time-zones) on the IANA website.
    ///
    /// Designators for time zones that don’t support Daylight Savings Time rules,
    /// such as
    /// Pacific Standard Time (PST), are not supported.
    time_zone_id: []const u8,

    pub const json_field_names = .{
        .contact_ids = "ContactIds",
        .idempotency_token = "IdempotencyToken",
        .name = "Name",
        .recurrence = "Recurrence",
        .start_time = "StartTime",
        .tags = "Tags",
        .time_zone_id = "TimeZoneId",
    };
};

pub const CreateRotationOutput = struct {
    /// The Amazon Resource Name (ARN) of the created rotation.
    rotation_arn: []const u8,

    pub const json_field_names = .{
        .rotation_arn = "RotationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRotationInput, options: CallOptions) !CreateRotationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ssmcontacts");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRotationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssmcontacts", "SSM Contacts", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.CreateRotation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRotationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateRotationOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "DataEncryptionException")) {
        return .{ .arena = arena, .kind = .{ .data_encryption_exception = .{
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
