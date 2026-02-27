const EmailAddressInfo = @import("email_address_info.zig").EmailAddressInfo;

/// Information about the additional recipients of outbound email.
pub const OutboundAdditionalRecipients = struct {
    /// Information about the **additional** CC email address recipients. Email
    /// recipients
    /// are limited to 50 total addresses: 1 required recipient in the
    /// [DestinationEmailAddress](https://docs.aws.amazon.com/connect/latest/APIReference/API_SendOutboundEmail.html#API_SendOutboundEmail_RequestBody) field and up to 49 recipients in the 'CcEmailAddresses' field.
    cc_email_addresses: ?[]const EmailAddressInfo,

    pub const json_field_names = .{
        .cc_email_addresses = "CcEmailAddresses",
    };
};
