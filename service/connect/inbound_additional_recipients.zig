const EmailAddressInfo = @import("email_address_info.zig").EmailAddressInfo;

/// Information about the additional TO and CC recipients of an inbound email
/// contact.
///
/// You can include up to 50 email addresses in total, distributed across
/// [DestinationEmailAddress](https://docs.aws.amazon.com/connect/latest/APIReference/API_StartEmailContact.html#API_StartEmailContact_RequestBody), `ToAddresses`, and `CcAddresses`. This total must include
/// one required `DestinationEmailAddress`. You can then specify up to 49
/// addresses allocated across
/// `ToAddresses` and `CcAddresses` as needed.
pub const InboundAdditionalRecipients = struct {
    /// The **additional** recipients information present in cc list. You must have
    /// 1
    /// required recipient (`DestinationEmailAddress`). You can then specify up to
    /// 49 additional recipients
    /// (across `ToAddresses` and `CcAddresses`), for a total of 50 recipients.
    cc_addresses: ?[]const EmailAddressInfo,

    /// The **additional** recipients information present in to list. You must have
    /// 1
    /// required recipient (`DestinationEmailAddress`). You can then specify up to
    /// 49 additional recipients
    /// (across `ToAddresses` and `CcAddresses`), for a total of 50 recipients.
    to_addresses: ?[]const EmailAddressInfo,

    pub const json_field_names = .{
        .cc_addresses = "CcAddresses",
        .to_addresses = "ToAddresses",
    };
};
