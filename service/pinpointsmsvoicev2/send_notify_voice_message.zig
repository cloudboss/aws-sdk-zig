const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VoiceId = @import("voice_id.zig").VoiceId;

pub const SendNotifyVoiceMessageInput = struct {
    /// The name of the configuration set to use. This can be either the
    /// ConfigurationSetName or ConfigurationSetArn.
    configuration_set_name: ?[]const u8 = null,

    /// You can specify custom data in this field. If you do, that data is logged to
    /// the event destination.
    context: ?[]const aws.map.StringMapEntry = null,

    /// The destination phone number in E.164 format.
    destination_phone_number: []const u8,

    /// When set to true, the message is checked and validated, but isn't sent to
    /// the end recipient.
    dry_run: ?bool = null,

    /// Set to true to enable message feedback for the message. When a user receives
    /// the message you need to update the message status using PutMessageFeedback.
    message_feedback_enabled: ?bool = null,

    /// The unique identifier of the notify configuration to use for sending the
    /// message. This can be either the NotifyConfigurationId or
    /// NotifyConfigurationArn.
    notify_configuration_id: []const u8,

    /// The unique identifier of the template to use for the message.
    template_id: ?[]const u8 = null,

    /// A map of template variable names and their values. All variable values are
    /// passed as strings regardless of the declared variable type. For example,
    /// pass `INTEGER` values as `"42"` and `BOOLEAN` values as `"true"` or
    /// `"false"`.
    template_variables: []const aws.map.StringMapEntry,

    /// How long the voice message is valid for, in seconds. By default this is 72
    /// hours.
    time_to_live: ?i32 = null,

    /// The voice ID to use for the voice message.
    voice_id: ?VoiceId = null,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .context = "Context",
        .destination_phone_number = "DestinationPhoneNumber",
        .dry_run = "DryRun",
        .message_feedback_enabled = "MessageFeedbackEnabled",
        .notify_configuration_id = "NotifyConfigurationId",
        .template_id = "TemplateId",
        .template_variables = "TemplateVariables",
        .time_to_live = "TimeToLive",
        .voice_id = "VoiceId",
    };
};

pub const SendNotifyVoiceMessageOutput = struct {
    /// The unique identifier for the message.
    message_id: ?[]const u8 = null,

    /// The message body after template variable substitution has been applied.
    resolved_message_body: ?[]const u8 = null,

    /// The unique identifier of the template used for the message.
    template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .message_id = "MessageId",
        .resolved_message_body = "ResolvedMessageBody",
        .template_id = "TemplateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendNotifyVoiceMessageInput, options: CallOptions) !SendNotifyVoiceMessageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendNotifyVoiceMessageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sms-voice", "Pinpoint SMS Voice V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.SendNotifyVoiceMessage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendNotifyVoiceMessageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SendNotifyVoiceMessageOutput, body, allocator);
}
