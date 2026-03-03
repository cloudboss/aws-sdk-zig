const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AccountPreferences = @import("account_preferences.zig").AccountPreferences;

pub const UpdateAccountPreferencesInput = struct {
    /// Turns on training data collection.
    ///
    /// This helps improve the AWS Chatbot experience by allowing AWS Chatbot to
    /// store and use your customer information, such as AWS Chatbot configurations,
    /// notifications, user inputs, AWS Chatbot generated responses, and interaction
    /// data. This data helps us to continuously improve and develop Artificial
    /// Intelligence (AI) technologies. Your data is not shared with any third
    /// parties and is protected using sophisticated controls to prevent
    /// unauthorized access and misuse. AWS Chatbot does not store or use
    /// interactions in chat channels with Amazon Q for training AI technologies for
    /// AWS Chatbot.
    training_data_collection_enabled: ?bool = null,

    /// Enables use of a user role requirement in your chat configuration.
    user_authorization_required: ?bool = null,

    pub const json_field_names = .{
        .training_data_collection_enabled = "TrainingDataCollectionEnabled",
        .user_authorization_required = "UserAuthorizationRequired",
    };
};

pub const UpdateAccountPreferencesOutput = struct {
    /// Preferences related to AWS Chatbot usage in the calling AWS account.
    account_preferences: ?AccountPreferences = null,

    pub const json_field_names = .{
        .account_preferences = "AccountPreferences",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccountPreferencesInput, options: CallOptions) !UpdateAccountPreferencesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccountPreferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chatbot", "chatbot", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/update-account-preferences";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.training_data_collection_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TrainingDataCollectionEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.user_authorization_required) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UserAuthorizationRequired\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccountPreferencesOutput {
    var result: UpdateAccountPreferencesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAccountPreferencesOutput, body, allocator);
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
