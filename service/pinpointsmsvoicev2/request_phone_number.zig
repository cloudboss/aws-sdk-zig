const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MessageType = @import("message_type.zig").MessageType;
const NumberCapability = @import("number_capability.zig").NumberCapability;
const NumberPreferenceItem = @import("number_preference_item.zig").NumberPreferenceItem;
const RequestableNumberType = @import("requestable_number_type.zig").RequestableNumberType;
const Tag = @import("tag.zig").Tag;
const NumberStatus = @import("number_status.zig").NumberStatus;

pub const RequestPhoneNumberInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. If you don't specify a client token, a randomly generated
    /// token is used for the request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// By default this is set to false. When set to true the phone number can't be
    /// deleted.
    deletion_protection_enabled: ?bool = null,

    /// By default this is set to false. When set to true the international sending
    /// of phone number is Enabled.
    international_sending_enabled: ?bool = null,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: []const u8,

    /// The type of message. Valid values are `TRANSACTIONAL` for messages that are
    /// critical or time-sensitive and `PROMOTIONAL` for messages that aren't
    /// critical or time-sensitive.
    message_type: MessageType,

    /// Indicates if the phone number will be used for text messages, voice
    /// messages, or both.
    number_capabilities: []const NumberCapability,

    /// An optional selection preference used to request a specific phone number,
    /// such as a number that starts with, ends with, or contains a particular digit
    /// pattern. You can specify at most one preference. Number preferences apply
    /// only to `TEN_DLC` requests in the `US`.
    number_preference: ?[]const NumberPreferenceItem = null,

    /// The type of phone number to request.
    ///
    /// When you request a `SIMULATOR` phone number, you must set **MessageType** as
    /// `TRANSACTIONAL`.
    number_type: RequestableNumberType,

    /// The name of the OptOutList to associate with the phone number. You can use
    /// the OptOutListName or OptOutListArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    opt_out_list_name: ?[]const u8 = null,

    /// The pool to associated with the phone number. You can use the PoolId or
    /// PoolArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    pool_id: ?[]const u8 = null,

    /// Use this field to attach your phone number for an external registration
    /// process.
    registration_id: ?[]const u8 = null,

    /// An array of tags (key and value pairs) to associate with the requested phone
    /// number.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .international_sending_enabled = "InternationalSendingEnabled",
        .iso_country_code = "IsoCountryCode",
        .message_type = "MessageType",
        .number_capabilities = "NumberCapabilities",
        .number_preference = "NumberPreference",
        .number_type = "NumberType",
        .opt_out_list_name = "OptOutListName",
        .pool_id = "PoolId",
        .registration_id = "RegistrationId",
        .tags = "Tags",
    };
};

pub const RequestPhoneNumberOutput = struct {
    /// The time when the phone number was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: ?i64 = null,

    /// By default this is set to false. When set to true the phone number can't be
    /// deleted.
    deletion_protection_enabled: ?bool = null,

    /// By default this is set to false. When set to true the international sending
    /// of phone number is Enabled.
    international_sending_enabled: ?bool = null,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: ?[]const u8 = null,

    /// The type of message. Valid values are TRANSACTIONAL for messages that are
    /// critical or time-sensitive and PROMOTIONAL for messages that aren't critical
    /// or time-sensitive.
    message_type: ?MessageType = null,

    /// The monthly price, in US dollars, to lease the phone number.
    monthly_leasing_price: ?[]const u8 = null,

    /// Indicates if the phone number will be used for text messages, voice messages
    /// or both.
    number_capabilities: ?[]const NumberCapability = null,

    /// The type of number that was released.
    number_type: ?RequestableNumberType = null,

    /// The name of the OptOutList that is associated with the requested phone
    /// number.
    opt_out_list_name: ?[]const u8 = null,

    /// The new phone number that was requested.
    phone_number: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the requested phone number.
    phone_number_arn: ?[]const u8 = null,

    /// The unique identifier of the new phone number.
    phone_number_id: ?[]const u8 = null,

    /// The unique identifier of the pool associated with the phone number
    pool_id: ?[]const u8 = null,

    /// The unique identifier for the registration.
    registration_id: ?[]const u8 = null,

    /// By default this is set to false. When set to false and an end recipient
    /// sends a message that begins with HELP or STOP to one of your dedicated
    /// numbers, End User Messaging SMS automatically replies with a customizable
    /// message and adds the end recipient to the OptOutList. When set to true
    /// you're responsible for responding to HELP and STOP requests. You're also
    /// responsible for tracking and honoring opt-out requests.
    self_managed_opt_outs_enabled: ?bool = null,

    /// The current status of the request.
    status: ?NumberStatus = null,

    /// An array of key and value pair tags that are associated with the phone
    /// number.
    tags: ?[]const Tag = null,

    /// The ARN used to identify the two way channel.
    two_way_channel_arn: ?[]const u8 = null,

    /// An optional IAM Role Arn for a service to assume, to be able to post inbound
    /// SMS messages.
    two_way_channel_role: ?[]const u8 = null,

    /// By default this is set to false. When set to true you can receive incoming
    /// text messages from your end recipients.
    two_way_enabled: ?bool = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .international_sending_enabled = "InternationalSendingEnabled",
        .iso_country_code = "IsoCountryCode",
        .message_type = "MessageType",
        .monthly_leasing_price = "MonthlyLeasingPrice",
        .number_capabilities = "NumberCapabilities",
        .number_type = "NumberType",
        .opt_out_list_name = "OptOutListName",
        .phone_number = "PhoneNumber",
        .phone_number_arn = "PhoneNumberArn",
        .phone_number_id = "PhoneNumberId",
        .pool_id = "PoolId",
        .registration_id = "RegistrationId",
        .self_managed_opt_outs_enabled = "SelfManagedOptOutsEnabled",
        .status = "Status",
        .tags = "Tags",
        .two_way_channel_arn = "TwoWayChannelArn",
        .two_way_channel_role = "TwoWayChannelRole",
        .two_way_enabled = "TwoWayEnabled",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RequestPhoneNumberInput, options: CallOptions) !RequestPhoneNumberOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RequestPhoneNumberInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.RequestPhoneNumber");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RequestPhoneNumberOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RequestPhoneNumberOutput, body, allocator);
}
