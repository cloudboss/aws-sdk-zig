const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LanguageCode = @import("language_code.zig").LanguageCode;
const VerificationChannel = @import("verification_channel.zig").VerificationChannel;

pub const SendDestinationNumberVerificationCodeInput = struct {
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
    destination_country_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Choose the language to use for the message.
    language_code: ?LanguageCode = null,

    /// The origination identity of the message. This can be either the PhoneNumber,
    /// PhoneNumberId, PhoneNumberArn, SenderId, SenderIdArn, PoolId, or PoolArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    origination_identity: ?[]const u8 = null,

    /// Choose to send the verification code as an SMS or voice message.
    verification_channel: VerificationChannel,

    /// The unique identifier for the verified destination phone number.
    verified_destination_number_id: []const u8,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .context = "Context",
        .destination_country_parameters = "DestinationCountryParameters",
        .language_code = "LanguageCode",
        .origination_identity = "OriginationIdentity",
        .verification_channel = "VerificationChannel",
        .verified_destination_number_id = "VerifiedDestinationNumberId",
    };
};

pub const SendDestinationNumberVerificationCodeOutput = struct {
    /// The unique identifier for the message.
    message_id: []const u8,

    pub const json_field_names = .{
        .message_id = "MessageId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendDestinationNumberVerificationCodeInput, options: CallOptions) !SendDestinationNumberVerificationCodeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendDestinationNumberVerificationCodeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.SendDestinationNumberVerificationCode");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendDestinationNumberVerificationCodeOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(SendDestinationNumberVerificationCodeOutput, body, allocator);
}
