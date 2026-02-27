/// Represents the destination of the message, consisting of To:, CC:, and BCC:
/// fields.
///
/// Amazon SES does not support the SMTPUTF8 extension, as described in
/// [RFC6531](https://tools.ietf.org/html/rfc6531). For this reason, the
/// email address string must be 7-bit ASCII. If you want to send to or from
/// email
/// addresses that contain Unicode characters in the domain part of an address,
/// you must
/// encode the domain using Punycode. Punycode is not permitted in the local
/// part of the
/// email address (the part before the @ sign) nor in the "friendly from" name.
/// If you
/// want to use Unicode characters in the "friendly from" name, you must encode
/// the
/// "friendly from" name using MIME encoded-word syntax, as described in
/// [Sending raw email
/// using the Amazon SES
/// API](https://docs.aws.amazon.com/ses/latest/dg/send-email-raw.html). For
/// more information about Punycode, see [RFC
/// 3492](http://tools.ietf.org/html/rfc3492).
pub const Destination = struct {
    /// The recipients to place on the BCC: line of the message.
    bcc_addresses: ?[]const []const u8,

    /// The recipients to place on the CC: line of the message.
    cc_addresses: ?[]const []const u8,

    /// The recipients to place on the To: line of the message.
    to_addresses: ?[]const []const u8,
};
