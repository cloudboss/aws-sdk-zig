/// Settings that allow management of telephony permissions for an Amazon Chime
/// user, such as
/// inbound and outbound calling and text messaging.
pub const TelephonySettings = struct {
    /// Allows or denies inbound calling.
    inbound_calling: bool,

    /// Allows or denies outbound calling.
    outbound_calling: bool,

    /// Allows or denies SMS messaging.
    sms: bool,

    pub const json_field_names = .{
        .inbound_calling = "InboundCalling",
        .outbound_calling = "OutboundCalling",
        .sms = "SMS",
    };
};
