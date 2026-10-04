const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SendMediaMessageInput = struct {
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

    /// The maximum amount that you want to spend, in US dollars, per each MMS
    /// message.
    max_price: ?[]const u8 = null,

    /// An array of URLs to each media file to send.
    ///
    /// The media files have to be stored in an S3 bucket. Supported media file
    /// formats are listed in [MMS file types, size and character
    /// limits](https://docs.aws.amazon.com/sms-voice/latest/userguide/mms-limitations-character.html). For more information on creating an S3 bucket and managing objects, see [Creating a bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/create-bucket-overview.html), [Uploading objects](https://docs.aws.amazon.com/AmazonS3/latest/userguide/upload-objects.html) in the *Amazon S3 User Guide*, and [Setting up an Amazon S3 bucket for MMS files](https://docs.aws.amazon.com/sms-voice/latest/userguide/send-mms-message.html#send-mms-message-bucket) in the *Amazon Web Services End User Messaging SMS User Guide*.
    media_urls: ?[]const []const u8 = null,

    /// The text body of the message.
    message_body: ?[]const u8 = null,

    /// Set to true to enable message feedback for the message. When a user receives
    /// the message you need to update the message status using PutMessageFeedback.
    message_feedback_enabled: ?bool = null,

    /// The origination identity of the message. This can be either the PhoneNumber,
    /// PhoneNumberId, PhoneNumberArn, SenderId, SenderIdArn, PoolId, or PoolArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    origination_identity: []const u8,

    /// The unique identifier of the protect configuration to use.
    protect_configuration_id: ?[]const u8 = null,

    /// How long the media message is valid for. By default this is 72 hours.
    time_to_live: ?i32 = null,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .context = "Context",
        .destination_phone_number = "DestinationPhoneNumber",
        .dry_run = "DryRun",
        .max_price = "MaxPrice",
        .media_urls = "MediaUrls",
        .message_body = "MessageBody",
        .message_feedback_enabled = "MessageFeedbackEnabled",
        .origination_identity = "OriginationIdentity",
        .protect_configuration_id = "ProtectConfigurationId",
        .time_to_live = "TimeToLive",
    };
};

pub const SendMediaMessageOutput = struct {
    /// The unique identifier for the message.
    message_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .message_id = "MessageId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendMediaMessageInput, options: CallOptions) !SendMediaMessageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendMediaMessageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.SendMediaMessage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendMediaMessageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SendMediaMessageOutput, body, allocator);
}
