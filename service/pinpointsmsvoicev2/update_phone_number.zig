const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MessageType = @import("message_type.zig").MessageType;
const NumberCapability = @import("number_capability.zig").NumberCapability;
const NumberType = @import("number_type.zig").NumberType;
const NumberStatus = @import("number_status.zig").NumberStatus;

pub const UpdatePhoneNumberInput = struct {
    /// By default this is set to false. When set to true the phone number can't be
    /// deleted.
    deletion_protection_enabled: ?bool = null,

    /// By default this is set to false. When set to true the international sending
    /// of phone number is Enabled.
    international_sending_enabled: ?bool = null,

    /// The OptOutList to add the phone number to. You can use either the opt out
    /// list name or the opt out list ARN.
    opt_out_list_name: ?[]const u8 = null,

    /// The unique identifier of the phone number. Valid values for this field can
    /// be either the PhoneNumberId or PhoneNumberArn.
    ///
    /// If you are using a shared End User Messaging SMS resource then you must use
    /// the full Amazon Resource Name(ARN).
    phone_number_id: []const u8,

    /// By default this is set to false. When set to false and an end recipient
    /// sends a message that begins with HELP or STOP to one of your dedicated
    /// numbers, End User Messaging SMS automatically replies with a customizable
    /// message and adds the end recipient to the OptOutList. When set to true
    /// you're responsible for responding to HELP and STOP requests. You're also
    /// responsible for tracking and honoring opt-out requests.
    self_managed_opt_outs_enabled: ?bool = null,

    /// The Amazon Resource Name (ARN) of the two way channel.
    two_way_channel_arn: ?[]const u8 = null,

    /// An optional IAM Role Arn for a service to assume, to be able to post inbound
    /// SMS messages.
    two_way_channel_role: ?[]const u8 = null,

    /// By default this is set to false. When set to true you can receive incoming
    /// text messages from your end recipients.
    two_way_enabled: ?bool = null,

    pub const json_field_names = .{
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .international_sending_enabled = "InternationalSendingEnabled",
        .opt_out_list_name = "OptOutListName",
        .phone_number_id = "PhoneNumberId",
        .self_managed_opt_outs_enabled = "SelfManagedOptOutsEnabled",
        .two_way_channel_arn = "TwoWayChannelArn",
        .two_way_channel_role = "TwoWayChannelRole",
        .two_way_enabled = "TwoWayEnabled",
    };
};

pub const UpdatePhoneNumberOutput = struct {
    /// The time when the phone number was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: ?i64 = null,

    /// When set to true the phone number can't be deleted.
    deletion_protection_enabled: ?bool = null,

    /// When set to true the international sending of phone number is Enabled.
    international_sending_enabled: ?bool = null,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: ?[]const u8 = null,

    /// The type of message. Valid values are TRANSACTIONAL for messages that are
    /// critical or time-sensitive and PROMOTIONAL for messages that aren't critical
    /// or time-sensitive.
    message_type: ?MessageType = null,

    /// The monthly leasing price of the phone number, in US dollars.
    monthly_leasing_price: ?[]const u8 = null,

    /// Specifies if the number could be used for text messages, voice or both.
    number_capabilities: ?[]const NumberCapability = null,

    /// The type of number that was requested.
    number_type: ?NumberType = null,

    /// The name of the OptOutList associated with the phone number.
    opt_out_list_name: ?[]const u8 = null,

    /// The phone number that was updated.
    phone_number: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the updated phone number.
    phone_number_arn: ?[]const u8 = null,

    /// The unique identifier of the phone number.
    phone_number_id: ?[]const u8 = null,

    /// The unique identifier for the registration.
    registration_id: ?[]const u8 = null,

    /// This is true if self managed opt-out are enabled.
    self_managed_opt_outs_enabled: ?bool = null,

    /// The current status of the request.
    status: ?NumberStatus = null,

    /// The Amazon Resource Name (ARN) of the two way channel.
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
        .registration_id = "RegistrationId",
        .self_managed_opt_outs_enabled = "SelfManagedOptOutsEnabled",
        .status = "Status",
        .two_way_channel_arn = "TwoWayChannelArn",
        .two_way_channel_role = "TwoWayChannelRole",
        .two_way_enabled = "TwoWayEnabled",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePhoneNumberInput, options: CallOptions) !UpdatePhoneNumberOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePhoneNumberInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PinpointSMSVoiceV2.UpdatePhoneNumber");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePhoneNumberOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdatePhoneNumberOutput, body, allocator);
}
