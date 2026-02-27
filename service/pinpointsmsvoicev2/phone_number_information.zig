const MessageType = @import("message_type.zig").MessageType;
const NumberCapability = @import("number_capability.zig").NumberCapability;
const NumberType = @import("number_type.zig").NumberType;
const NumberStatus = @import("number_status.zig").NumberStatus;

/// The information for a phone number, in E.164 format, in an Amazon Web
/// Services account.
pub const PhoneNumberInformation = struct {
    /// The time when the phone number was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// When set to true the phone number can't be deleted.
    deletion_protection_enabled: bool = false,

    /// When set to true the international sending of phone number is Enabled.
    international_sending_enabled: bool = false,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: []const u8,

    /// The type of message. Valid values are TRANSACTIONAL for messages that are
    /// critical or time-sensitive and PROMOTIONAL for messages that aren't critical
    /// or time-sensitive.
    message_type: MessageType,

    /// The price, in US dollars, to lease the phone number.
    monthly_leasing_price: []const u8,

    /// Describes if the origination identity can be used for text messages, voice
    /// calls or both.
    number_capabilities: []const NumberCapability,

    /// The type of phone number.
    number_type: NumberType,

    /// The name of the OptOutList associated with the phone number.
    opt_out_list_name: []const u8,

    /// The phone number in E.164 format.
    phone_number: []const u8,

    /// The Amazon Resource Name (ARN) associated with the phone number.
    phone_number_arn: []const u8,

    /// The unique identifier for the phone number.
    phone_number_id: ?[]const u8,

    /// The unique identifier of the pool associated with the phone number.
    pool_id: ?[]const u8,

    /// The unique identifier for the registration.
    registration_id: ?[]const u8,

    /// When set to false and an end recipient sends a message that begins with HELP
    /// or STOP to one of your dedicated numbers, End User Messaging SMS
    /// automatically replies with a customizable message and adds the end recipient
    /// to the OptOutList. When set to true you're responsible for responding to
    /// HELP and STOP requests. You're also responsible for tracking and honoring
    /// opt-out request. For more information see [Self-managed
    /// opt-outs](https://docs.aws.amazon.com/pinpoint/latest/userguide/settings-sms-managing.html#settings-account-sms-self-managed-opt-out)
    self_managed_opt_outs_enabled: bool = false,

    /// The current status of the phone number.
    status: NumberStatus,

    /// The Amazon Resource Name (ARN) of the two way channel.
    two_way_channel_arn: ?[]const u8,

    /// An optional IAM Role Arn for a service to assume, to be able to post inbound
    /// SMS messages.
    two_way_channel_role: ?[]const u8,

    /// By default this is set to false. When set to true you can receive incoming
    /// text messages from your end recipients using the TwoWayChannelArn.
    two_way_enabled: bool = false,

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
        .two_way_channel_arn = "TwoWayChannelArn",
        .two_way_channel_role = "TwoWayChannelRole",
        .two_way_enabled = "TwoWayEnabled",
    };
};
