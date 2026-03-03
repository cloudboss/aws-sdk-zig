const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CrossAccountConfiguration = @import("cross_account_configuration.zig").CrossAccountConfiguration;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;

pub const GetInvestigationGroupInput = struct {
    /// Specify either the name or the ARN of the investigation group that you want
    /// to view. This is used to set the name of the investigation group.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};

pub const GetInvestigationGroupOutput = struct {
    /// The Amazon Resource Name (ARN) of the investigation group.
    arn: ?[]const u8 = null,

    /// This structure is a string array. The first string is the ARN of a Amazon
    /// SNS topic. The array of strings display the ARNs of chat applications
    /// configurations that are associated with that topic. For more information
    /// about these configuration ARNs, see [Getting started with Amazon Q in chat
    /// applications](https://docs.aws.amazon.com/chatbot/latest/adminguide/getting-started.html) and [Resource type defined by Amazon Web Services Chatbot](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awschatbot.html#awschatbot-resources-for-iam-policies).
    chatbot_notification_channel: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The date and time that the investigation group was created.
    created_at: ?i64 = null,

    /// The name of the user who created the investigation group.
    created_by: ?[]const u8 = null,

    /// Lists the `AWSAccountId` of the accounts configured for cross-account access
    /// and the results of the last scan performed on each account.
    cross_account_configurations: ?[]const CrossAccountConfiguration = null,

    /// Specifies the customer managed KMS key that the investigation group uses to
    /// encrypt data, if there is one. If not, the investigation group uses an
    /// Amazon Web Services key to encrypt the data.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// Specifies whether CloudWatch investigationshas access to change events that
    /// are recorded by CloudTrail.
    is_cloud_trail_event_history_enabled: ?bool = null,

    /// The date and time that the investigation group was most recently modified.
    last_modified_at: ?i64 = null,

    /// The name of the user who created the investigation group.
    last_modified_by: ?[]const u8 = null,

    /// The name of the investigation group.
    name: ?[]const u8 = null,

    /// Specifies how long that investigation data is kept.
    retention_in_days: ?i64 = null,

    /// The ARN of the IAM role that the investigation group uses for permissions to
    /// gather data.
    role_arn: ?[]const u8 = null,

    /// Displays the custom tag keys for custom applications in your system that you
    /// have specified in the investigation group. Resource tags help CloudWatch
    /// investigations narrow the search space when it is unable to discover
    /// definite relationships between resources.
    tag_key_boundaries: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .chatbot_notification_channel = "chatbotNotificationChannel",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .cross_account_configurations = "crossAccountConfigurations",
        .encryption_configuration = "encryptionConfiguration",
        .is_cloud_trail_event_history_enabled = "isCloudTrailEventHistoryEnabled",
        .last_modified_at = "lastModifiedAt",
        .last_modified_by = "lastModifiedBy",
        .name = "name",
        .retention_in_days = "retentionInDays",
        .role_arn = "roleArn",
        .tag_key_boundaries = "tagKeyBoundaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInvestigationGroupInput, options: CallOptions) !GetInvestigationGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "aiops");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInvestigationGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aiops", "AIOps", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/investigationGroups/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInvestigationGroupOutput {
    var result: GetInvestigationGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetInvestigationGroupOutput, body, allocator);
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
