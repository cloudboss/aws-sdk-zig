const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CrossAccountConfiguration = @import("cross_account_configuration.zig").CrossAccountConfiguration;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;

pub const CreateInvestigationGroupInput = struct {
    /// Use this structure to integrate CloudWatch investigations with chat
    /// applications. This structure is a string array. For the first string,
    /// specify the ARN of an Amazon SNS topic. For the array of strings, specify
    /// the ARNs of one or more chat applications configurations that you want to
    /// associate with that topic. For more information about these configuration
    /// ARNs, see [Getting started with Amazon Q in chat
    /// applications](https://docs.aws.amazon.com/chatbot/latest/adminguide/getting-started.html) and [Resource type defined by Amazon Web Services Chatbot](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awschatbot.html#awschatbot-resources-for-iam-policies).
    chatbot_notification_channel: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// List of `sourceRoleArn` values that have been configured for cross-account
    /// access.
    cross_account_configurations: ?[]const CrossAccountConfiguration = null,

    /// Use this structure if you want to use a customer managed KMS key to encrypt
    /// your investigation data. If you omit this parameter, CloudWatch
    /// investigations will use an Amazon Web Services key to encrypt the data. For
    /// more information, see [Encryption of investigation
    /// data](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Investigations-Security.html#Investigations-KMS).
    encryption_configuration: ?EncryptionConfiguration = null,

    /// Specify `true` to enable CloudWatch investigations to have access to change
    /// events that are recorded by CloudTrail. The default is `true`.
    is_cloud_trail_event_history_enabled: ?bool = null,

    /// Provides a name for the investigation group.
    name: []const u8,

    /// Specify how long that investigation data is kept. For more information, see
    /// [Operational investigation data
    /// retention](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Investigations-Retention.html).
    ///
    /// If you omit this parameter, the default of 90 days is used.
    retention_in_days: ?i64 = null,

    /// Specify the ARN of the IAM role that CloudWatch investigations will use when
    /// it gathers investigation data. The permissions in this role determine which
    /// of your resources that CloudWatch investigations will have access to during
    /// investigations.
    ///
    /// For more information, see [How to control what data CloudWatch
    /// investigations has access to during
    /// investigations](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Investigations-Security.html#Investigations-Security-Data).
    role_arn: []const u8,

    /// Enter the existing custom tag keys for custom applications in your system.
    /// Resource tags help CloudWatch investigations narrow the search space when it
    /// is unable to discover definite relationships between resources. For example,
    /// to discover that an Amazon ECS service depends on an Amazon RDS database,
    /// CloudWatch investigations can discover this relationship using data sources
    /// such as X-Ray and CloudWatch Application Signals. However, if you haven't
    /// deployed these features, CloudWatch investigations will attempt to identify
    /// possible relationships. Tag boundaries can be used to narrow the resources
    /// that will be discovered by CloudWatch investigations in these cases.
    ///
    /// You don't need to enter tags created by myApplications or CloudFormation,
    /// because CloudWatch investigations can automatically detect those tags.
    tag_key_boundaries: ?[]const []const u8 = null,

    /// A list of key-value pairs to associate with the investigation group. You can
    /// associate as many as 50 tags with an investigation group. To be able to
    /// associate tags when you create the investigation group, you must have the
    /// `cloudwatch:TagResource` permission.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to scope user permissions by granting a user permission to access or
    /// change only resources with certain tag values.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .chatbot_notification_channel = "chatbotNotificationChannel",
        .cross_account_configurations = "crossAccountConfigurations",
        .encryption_configuration = "encryptionConfiguration",
        .is_cloud_trail_event_history_enabled = "isCloudTrailEventHistoryEnabled",
        .name = "name",
        .retention_in_days = "retentionInDays",
        .role_arn = "roleArn",
        .tag_key_boundaries = "tagKeyBoundaries",
        .tags = "tags",
    };
};

pub const CreateInvestigationGroupOutput = struct {
    /// The ARN of the investigation group that you just created.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInvestigationGroupInput, options: Options) !CreateInvestigationGroupOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateInvestigationGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aiops", "AIOps", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/investigationGroups";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.chatbot_notification_channel) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"chatbotNotificationChannel\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.cross_account_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"crossAccountConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.encryption_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"encryptionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.is_cloud_trail_event_history_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"isCloudTrailEventHistoryEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, alloc, &body_buf);
    has_prev = true;
    if (input.retention_in_days) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"retentionInDays\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, alloc, &body_buf);
    has_prev = true;
    if (input.tag_key_boundaries) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tagKeyBoundaries\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateInvestigationGroupOutput {
    var result: CreateInvestigationGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateInvestigationGroupOutput, body, alloc);
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
