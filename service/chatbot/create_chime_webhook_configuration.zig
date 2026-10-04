const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChimeWebhookConfigurationInput, options: CallOptions) !CreateChimeWebhookConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateChimeWebhookConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chatbot", "chatbot", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/create-chime-webhook-configuration";

    var body_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateChimeWebhookConfigurationOutput {
    const result: CreateChimeWebhookConfigurationOutput = try aws.json.parseJsonObject(
        CreateChimeWebhookConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
