const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const DescribeEngagementInput = struct {
    /// The Amazon Resource Name (ARN) of the engagement you want the details of.
    engagement_id: []const u8,

    pub const json_field_names = .{
        .engagement_id = "EngagementId",
    };
};

pub const DescribeEngagementOutput = struct {
    /// The ARN of the escalation plan or contacts involved in the engagement.
    contact_arn: []const u8,

    /// The secure content of the message that was sent to the contact. Use this
    /// field for
    /// engagements to `VOICE` and `EMAIL`.
    content: []const u8,

    /// The ARN of the engagement.
    engagement_arn: []const u8,

    /// The ARN of the incident in which the engagement occurred.
    incident_id: ?[]const u8 = null,

    /// The insecure content of the message that was sent to the contact. Use this
    /// field for
    /// engagements to `SMS`.
    public_content: ?[]const u8 = null,

    /// The insecure subject of the message that was sent to the contact. Use this
    /// field for
    /// engagements to `SMS`.
    public_subject: ?[]const u8 = null,

    /// The user that started the engagement.
    sender: []const u8,

    /// The time that the engagement started.
    start_time: ?i64 = null,

    /// The time that the engagement ended.
    stop_time: ?i64 = null,

    /// The secure subject of the message that was sent to the contact. Use this
    /// field for
    /// engagements to `VOICE` and `EMAIL`.
    subject: []const u8,

    pub const json_field_names = .{
        .contact_arn = "ContactArn",
        .content = "Content",
        .engagement_arn = "EngagementArn",
        .incident_id = "IncidentId",
        .public_content = "PublicContent",
        .public_subject = "PublicSubject",
        .sender = "Sender",
        .start_time = "StartTime",
        .stop_time = "StopTime",
        .subject = "Subject",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEngagementInput, options: CallOptions) !DescribeEngagementOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEngagementInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SSMContacts.DescribeEngagement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEngagementOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeEngagementOutput, body, allocator);
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
