/// An object that describes the recipients for an email.
///
/// Amazon SES does not support the SMTPUTF8 extension, as described in
/// [RFC6531](https://tools.ietf.org/html/rfc6531). For this reason, the
/// *local part* of a destination email address (the part of the
/// email address that precedes the @ sign) may only contain [7-bit ASCII
/// characters](https://en.wikipedia.org/wiki/Email_address#Local-part). If the
/// *domain part* of an address (the
/// part after the @ sign) contains non-ASCII characters, they must be encoded
/// using
/// Punycode, as described in
/// [RFC3492](https://tools.ietf.org/html/rfc3492.html).
pub const Destination = struct {
    /// An array that contains the email addresses of the "BCC" (blind carbon copy)
    /// recipients
    /// for the email.
    bcc_addresses: ?[]const []const u8,

    /// An array that contains the email addresses of the "CC" (carbon copy)
    /// recipients for
    /// the email.
    cc_addresses: ?[]const []const u8,

    /// An array that contains the email addresses of the "To" recipients for the
    /// email.
    to_addresses: ?[]const []const u8,

    pub const json_field_names = .{
        .bcc_addresses = "BccAddresses",
        .cc_addresses = "CcAddresses",
        .to_addresses = "ToAddresses",
    };
};
