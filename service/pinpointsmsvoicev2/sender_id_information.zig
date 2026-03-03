const MessageType = @import("message_type.zig").MessageType;

/// The information for all SenderIds in an Amazon Web Services account.
pub const SenderIdInformation = struct {
    /// By default this is set to false. When set to true the sender ID can't be
    /// deleted.
    deletion_protection_enabled: bool = false,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: []const u8,

    /// The type of message. Valid values are TRANSACTIONAL for messages that are
    /// critical or time-sensitive and PROMOTIONAL for messages that aren't critical
    /// or time-sensitive.
    message_types: []const MessageType,

    /// The monthly leasing price, in US dollars.
    monthly_leasing_price: []const u8,

    /// True if the sender ID is registered.
    registered: bool = false,

    /// The unique identifier for the registration.
    registration_id: ?[]const u8 = null,

    /// The alphanumeric sender ID in a specific country that you'd like to
    /// describe.
    sender_id: []const u8,

    /// The Amazon Resource Name (ARN) associated with the SenderId.
    sender_id_arn: []const u8,

    pub const json_field_names = .{
        .deletion_protection_enabled = "DeletionProtectionEnabled",
        .iso_country_code = "IsoCountryCode",
        .message_types = "MessageTypes",
        .monthly_leasing_price = "MonthlyLeasingPrice",
        .registered = "Registered",
        .registration_id = "RegistrationId",
        .sender_id = "SenderId",
        .sender_id_arn = "SenderIdArn",
    };
};
