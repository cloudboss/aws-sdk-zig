const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MessageType = @import("message_type.zig").MessageType;

pub const SendTextMessageInput = struct {
    /// The name of the configuration set to use. This can be either the
    /// ConfigurationSetName or ConfigurationSetArn.
    configuration_set_name: ?[]const u8 = null,

    /// You can specify custom data in this field. If you do, that data is logged to
    /// the event destination.
    context: ?[]const aws.map.StringMapEntry = null,

    /// This field is used for any country-specific registration requirements.
    /// Currently, this setting is only used when you send messages to recipients in
    /// India using a sender ID. For more information see [Special requirements for
    /// sending SMS messages to recipients in
    /// India](https://docs.aws.amazon.com/pinpoint/latest/userguide/channels-sms-senderid-india.html).
    ///
    /// * `IN_ENTITY_ID` The entity ID or Principal Entity (PE) ID that you received
    ///   after completing the sender ID registration process.
    /// * `IN_TEMPLATE_ID` The template ID that you received after completing the
    ///   sender ID registration process.
    ///
    /// Make sure that the Template ID that you specify matches your message
    /// template exactly. If your message doesn't match the template that you
    /// provided during the registration process, the mobile carriers might reject
    /// your message.
    destination_country_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The destination phone number in E.164 format.
    destination_phone_number: []const u8,

    /// When set to true, the message is checked and validated, but isn't sent to
    /// the end recipient. You are not charged for using `DryRun`.
    ///
    /// The Message Parts per Second (MPS) limit when using `DryRun` is five. If
    /// your origination identity has a lower MPS limit then the lower MPS limit is
    /// used. For more information about MPS limits, see [Message Parts per Second
    /// (MPS)
    /// limits](https://docs.aws.amazon.com/sms-voice/latest/userguide/sms-limitations-mps.html) in the *End User Messaging SMS User Guide*..
    dry_run: ?bool = null,

    /// When you register a short code in the US, you must specify a program name.
    /// If you don’t have a US short code, omit this attribute.
    keyword: ?[]const u8 = null,

    /// The maximum amount that you want to spend, in US dollars, per each text
    /// message. If the calculated amount to send the text message is greater than
    /// `MaxPrice`, the message is not sent and an error is returned.
    max_price: ?[]const u8 = null,

    /// The body of the text message.
    message_body: ?[]const u8 = null,

    /// Set to true to enable message feedback for the message. When a user receives
    /// the message you need to update the message status using PutMessageFeedback.
    message_feedback_enabled: ?bool = null,

    /// The type of message. Valid values are for messages that are critical or
    /// time-sensitive and PROMOTIONAL for messages that aren't critical or
    /// time-sensitive.
    message_type: ?MessageType = null,

    /// The origination identity of the message. This can be either the PhoneNumber,
    /// PhoneNumberId, PhoneNumberArn, SenderId, SenderIdArn, PoolId, or PoolArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    origination_identity: ?[]const u8 = null,

    /// The unique identifier for the protect configuration.
    protect_configuration_id: ?[]const u8 = null,

    /// How long the text message is valid for, in seconds. By default this is 72
    /// hours. If the messages isn't handed off before the TTL expires we stop
    /// attempting to hand off the message and return `TTL_EXPIRED` event.
    time_to_live: ?i32 = null,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .context = "Context",
        .destination_country_parameters = "DestinationCountryParameters",
        .destination_phone_number = "DestinationPhoneNumber",
        .dry_run = "DryRun",
        .keyword = "Keyword",
        .max_price = "MaxPrice",
        .message_body = "MessageBody",
        .message_feedback_enabled = "MessageFeedbackEnabled",
        .message_type = "MessageType",
        .origination_identity = "OriginationIdentity",
        .protect_configuration_id = "ProtectConfigurationId",
        .time_to_live = "TimeToLive",
    };
};

pub const SendTextMessageOutput = struct {
    /// The unique identifier for the message.
    message_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .message_id = "MessageId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendTextMessageInput, options: Options) !SendTextMessageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "pinpointsmsvoicev2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendTextMessageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pinpointsmsvoicev2", "Pinpoint SMS Voice V2", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.SendTextMessage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendTextMessageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SendTextMessageOutput, body, allocator);
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
