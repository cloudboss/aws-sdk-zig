const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const TeamsChannelConfiguration = @import("teams_channel_configuration.zig").TeamsChannelConfiguration;

pub const CreateMicrosoftTeamsChannelConfigurationInput = struct {
    /// The ID of the Microsoft Teams channel.
    channel_id: []const u8,

    /// The name of the Microsoft Teams channel.
    channel_name: ?[]const u8 = null,

    /// The name of the configuration.
    configuration_name: []const u8,

    /// The list of IAM policy ARNs that are applied as channel guardrails. The AWS
    /// managed `AdministratorAccess` policy is applied by default if this is not
    /// set.
    guardrail_policy_arns: ?[]const []const u8 = null,

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
    sns_topic_arns: ?[]const []const u8 = null,

    /// A map of tags assigned to a resource. A tag is a string-to-string map of
    /// key-value pairs.
    tags: ?[]const Tag = null,

    /// The ID of the Microsoft Teams authorized with AWS Chatbot.
    ///
    /// To get the team ID, you must perform the initial authorization flow with
    /// Microsoft Teams in the AWS Chatbot console. Then you can copy and paste the
    /// team ID from the console. For more information, see [Step 1: Configure a
    /// Microsoft Teams
    /// client](https://docs.aws.amazon.com/chatbot/latest/adminguide/teams-setup.html#teams-client-setup) in the * AWS Chatbot Administrator Guide*.
    team_id: []const u8,

    /// The name of the Microsoft Teams Team.
    team_name: ?[]const u8 = null,

    /// The ID of the Microsoft Teams tenant.
    tenant_id: []const u8,

    /// Enables use of a user role requirement in your chat configuration.
    user_authorization_required: ?bool = null,

    pub const json_field_names = .{
        .channel_id = "ChannelId",
        .channel_name = "ChannelName",
        .configuration_name = "ConfigurationName",
        .guardrail_policy_arns = "GuardrailPolicyArns",
        .iam_role_arn = "IamRoleArn",
        .logging_level = "LoggingLevel",
        .sns_topic_arns = "SnsTopicArns",
        .tags = "Tags",
        .team_id = "TeamId",
        .team_name = "TeamName",
        .tenant_id = "TenantId",
        .user_authorization_required = "UserAuthorizationRequired",
    };
};

pub const CreateMicrosoftTeamsChannelConfigurationOutput = struct {
    /// The configuration for a Microsoft Teams channel configured with AWS Chatbot.
    channel_configuration: ?TeamsChannelConfiguration = null,

    pub const json_field_names = .{
        .channel_configuration = "ChannelConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMicrosoftTeamsChannelConfigurationInput, options: CallOptions) !CreateMicrosoftTeamsChannelConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chatbot", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMicrosoftTeamsChannelConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chatbot", "chatbot", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/create-ms-teams-channel-configuration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChannelId\":");
    try aws.json.writeValue(@TypeOf(input.channel_id), input.channel_id, allocator, &body_buf);
    has_prev = true;
    if (input.channel_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ChannelName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConfigurationName\":");
    try aws.json.writeValue(@TypeOf(input.configuration_name), input.configuration_name, allocator, &body_buf);
    has_prev = true;
    if (input.guardrail_policy_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GuardrailPolicyArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.sns_topic_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SnsTopicArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TeamId\":");
    try aws.json.writeValue(@TypeOf(input.team_id), input.team_id, allocator, &body_buf);
    has_prev = true;
    if (input.team_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TeamName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TenantId\":");
    try aws.json.writeValue(@TypeOf(input.tenant_id), input.tenant_id, allocator, &body_buf);
    has_prev = true;
    if (input.user_authorization_required) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UserAuthorizationRequired\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMicrosoftTeamsChannelConfigurationOutput {
    var result: CreateMicrosoftTeamsChannelConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateMicrosoftTeamsChannelConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
