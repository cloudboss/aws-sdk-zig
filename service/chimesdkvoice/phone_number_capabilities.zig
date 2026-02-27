/// The phone number capabilities for Amazon Chime SDK phone numbers,
/// such as enabled inbound and outbound calling, and text messaging.
pub const PhoneNumberCapabilities = struct {
    /// Allows or denies inbound calling for the specified phone number.
    inbound_call: ?bool,

    /// Allows or denies inbound MMS messaging for the specified phone number.
    inbound_mms: ?bool,

    /// Allows or denies inbound SMS messaging for the specified phone number.
    inbound_sms: ?bool,

    /// Allows or denies outbound calling for the specified phone number.
    outbound_call: ?bool,

    /// Allows or denies inbound MMS messaging for the specified phone number.
    outbound_mms: ?bool,

    /// Allows or denies outbound SMS messaging for the specified phone number.
    outbound_sms: ?bool,

    pub const json_field_names = .{
        .inbound_call = "InboundCall",
        .inbound_mms = "InboundMMS",
        .inbound_sms = "InboundSMS",
        .outbound_call = "OutboundCall",
        .outbound_mms = "OutboundMMS",
        .outbound_sms = "OutboundSMS",
    };
};
