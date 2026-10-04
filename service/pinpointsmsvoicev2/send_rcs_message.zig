const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RcsFallbackConfiguration = @import("rcs_fallback_configuration.zig").RcsFallbackConfiguration;
const RcsMessageContent = @import("rcs_message_content.zig").RcsMessageContent;

pub const SendRcsMessageInput = struct {
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

    /// Configuration for SMS or MMS fallback when RCS delivery fails. If provided,
    /// the service sends a fallback message via the specified channel when the RCS
    /// message fails or the TimeToLive expires.
    fallback_configuration: ?RcsFallbackConfiguration = null,

    /// The maximum amount that you want to spend, in US dollars, per each RCS
    /// message.
    max_price: ?[]const u8 = null,

    /// Set to true to enable message feedback for the message. When a user receives
    /// the message you need to update the message status using PutMessageFeedback.
    message_feedback_enabled: ?bool = null,

    /// The traffic type of the RCS message. Valid values are AUTHENTICATION,
    /// TRANSACTION, PROMOTION, SERVICE_REQUEST, and ACKNOWLEDGEMENT. This field is
    /// reserved for future use.
    message_traffic_type: ?[]const u8 = null,

    /// The origination identity of the message. This can be either the RcsAgentId,
    /// RcsAgentArn, PoolId, or PoolArn.
    origination_identity: []const u8,

    /// The unique identifier of the protect configuration to use.
    protect_configuration_id: ?[]const u8 = null,

    /// The content of the RCS message. Contains the message content (text, file,
    /// rich card, or carousel) and optional message-level suggested actions.
    rcs_message_content: ?RcsMessageContent = null,

    /// The duration in seconds that the RCS message is valid for delivery. If the
    /// message cannot be delivered within this duration, it is considered expired.
    /// Valid values are 1 to 172800 (48 hours). If a FallbackConfiguration is
    /// provided, the fallback is triggered when the duration expires without
    /// delivery confirmation.
    time_to_live: ?i32 = null,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .context = "Context",
        .destination_phone_number = "DestinationPhoneNumber",
        .dry_run = "DryRun",
        .fallback_configuration = "FallbackConfiguration",
        .max_price = "MaxPrice",
        .message_feedback_enabled = "MessageFeedbackEnabled",
        .message_traffic_type = "MessageTrafficType",
        .origination_identity = "OriginationIdentity",
        .protect_configuration_id = "ProtectConfigurationId",
        .rcs_message_content = "RcsMessageContent",
        .time_to_live = "TimeToLive",
    };
};

pub const SendRcsMessageOutput = struct {
    /// The unique identifier for the message.
    message_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .message_id = "MessageId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendRcsMessageInput, options: CallOptions) !SendRcsMessageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendRcsMessageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.SendRcsMessage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendRcsMessageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SendRcsMessageOutput, body, allocator);
}
