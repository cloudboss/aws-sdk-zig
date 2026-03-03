const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;
const ChimeWebhookConfiguration = @import("chime_webhook_configuration.zig").ChimeWebhookConfiguration;

pub const CreateChimeWebhookConfigurationInput = struct {
    /// The name of the configuration.
    configuration_name: []const u8,

    /// A user-defined role that AWS Chatbot assumes. This is not the service-linked
    /// role.
    ///
    /// For more information, see [IAM policies for AWS
    /// Chatbot](https://docs.aws.amazon.com/chatbot/latest/adminguide/chatbot-iam-policies.html) in the * AWS Chatbot Administrator Guide*.
    iam_role_arn: []const u8,

    /// Logging levels include `ERROR`, `INFO`, or `NONE`.
    logging_level: ?[]const u8 = null,

    /// The Amazon Resource Names (ARNs) of the SNS topics that deliver
    /// notifications to AWS Chatbot.
    sns_topic_arns: []const []const u8,

    /// A map of tags assigned to a resource. A tag is a string-to-string map of
    /// key-value pairs.
    tags: ?[]const Tag = null,

    /// A description of the webhook. We recommend using the convention
    /// `RoomName/WebhookName`.
    ///
    /// For more information, see [Tutorial: Get started with Amazon
    /// Chime](https://docs.aws.amazon.com/chatbot/latest/adminguide/chime-setup.html) in the * AWS Chatbot Administrator Guide*.
    webhook_description: []const u8,

    /// The URL for the Amazon Chime webhook.
    webhook_url: []const u8,

    pub const json_field_names = .{
        .configuration_name = "ConfigurationName",
        .iam_role_arn = "IamRoleArn",
        .logging_level = "LoggingLevel",
        .sns_topic_arns = "SnsTopicArns",
        .tags = "Tags",
        .webhook_description = "WebhookDescription",
        .webhook_url = "WebhookUrl",
    };
};

pub const CreateChimeWebhookConfigurationOutput = struct {
    /// An Amazon Chime webhook configuration.
    webhook_configuration: ?ChimeWebhookConfiguration = null,

    pub const json_field_names = .{
        .webhook_configuration = "WebhookConfiguration",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChimeWebhookConfigurationInput, options: Options) !CreateChimeWebhookConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "chatbot");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateChimeWebhookConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chatbot", "chatbot", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/create-chime-webhook-configuration";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConfigurationName\":");
    try aws.json.writeValue(@TypeOf(input.configuration_name), input.configuration_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IamRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.iam_role_arn), input.iam_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.logging_level) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LoggingLevel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SnsTopicArns\":");
    try aws.json.writeValue(@TypeOf(input.sns_topic_arns), input.sns_topic_arns, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"WebhookDescription\":");
    try aws.json.writeValue(@TypeOf(input.webhook_description), input.webhook_description, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"WebhookUrl\":");
    try aws.json.writeValue(@TypeOf(input.webhook_url), input.webhook_url, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateChimeWebhookConfigurationOutput {
    var result: CreateChimeWebhookConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateChimeWebhookConfigurationOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CreateChimeWebhookConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .create_chime_webhook_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CreateSlackChannelConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .create_slack_channel_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CreateTeamsChannelConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .create_teams_channel_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeleteChimeWebhookConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .delete_chime_webhook_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeleteMicrosoftTeamsUserIdentityException")) {
        return .{ .arena = arena, .kind = .{ .delete_microsoft_teams_user_identity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeleteSlackChannelConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .delete_slack_channel_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeleteSlackUserIdentityException")) {
        return .{ .arena = arena, .kind = .{ .delete_slack_user_identity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeleteSlackWorkspaceAuthorizationFault")) {
        return .{ .arena = arena, .kind = .{ .delete_slack_workspace_authorization_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeleteTeamsChannelConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .delete_teams_channel_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeleteTeamsConfiguredTeamException")) {
        return .{ .arena = arena, .kind = .{ .delete_teams_configured_team_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DescribeChimeWebhookConfigurationsException")) {
        return .{ .arena = arena, .kind = .{ .describe_chime_webhook_configurations_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DescribeSlackChannelConfigurationsException")) {
        return .{ .arena = arena, .kind = .{ .describe_slack_channel_configurations_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DescribeSlackUserIdentitiesException")) {
        return .{ .arena = arena, .kind = .{ .describe_slack_user_identities_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DescribeSlackWorkspacesException")) {
        return .{ .arena = arena, .kind = .{ .describe_slack_workspaces_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GetAccountPreferencesException")) {
        return .{ .arena = arena, .kind = .{ .get_account_preferences_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GetTeamsChannelConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .get_teams_channel_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ListMicrosoftTeamsConfiguredTeamsException")) {
        return .{ .arena = arena, .kind = .{ .list_microsoft_teams_configured_teams_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ListMicrosoftTeamsUserIdentitiesException")) {
        return .{ .arena = arena, .kind = .{ .list_microsoft_teams_user_identities_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ListTeamsChannelConfigurationsException")) {
        return .{ .arena = arena, .kind = .{ .list_teams_channel_configurations_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UpdateAccountPreferencesException")) {
        return .{ .arena = arena, .kind = .{ .update_account_preferences_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UpdateChimeWebhookConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .update_chime_webhook_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UpdateSlackChannelConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .update_slack_channel_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UpdateTeamsChannelConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .update_teams_channel_configuration_exception = .{
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
