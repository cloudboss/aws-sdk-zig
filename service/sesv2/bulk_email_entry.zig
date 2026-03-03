const Destination = @import("destination.zig").Destination;
const ReplacementEmailContent = @import("replacement_email_content.zig").ReplacementEmailContent;
const MessageHeader = @import("message_header.zig").MessageHeader;
const MessageTag = @import("message_tag.zig").MessageTag;

pub const BulkEmailEntry = struct {
    /// Represents the destination of the message, consisting of To:, CC:, and BCC:
    /// fields.
    ///
    /// Amazon SES does not support the SMTPUTF8 extension, as described in
    /// [RFC6531](https://tools.ietf.org/html/rfc6531). For this reason, the
    /// local part of a destination email address (the part of the email address
    /// that
    /// precedes the @ sign) may only contain [7-bit ASCII
    /// characters](https://en.wikipedia.org/wiki/Email_address#Local-part). If the
    /// domain part of an address (the part after the @ sign)
    /// contains non-ASCII characters, they must be encoded using Punycode, as
    /// described in
    /// [RFC3492](https://tools.ietf.org/html/rfc3492.html).
    destination: Destination,

    /// The `ReplacementEmailContent` associated with a
    /// `BulkEmailEntry`.
    replacement_email_content: ?ReplacementEmailContent = null,

    /// The list of message headers associated with the `BulkEmailEntry` data type.
    ///
    /// * Headers Not Present in `BulkEmailEntry`: If a header is specified in
    /// [
    /// `Template`
    /// ](https://docs.aws.amazon.com/ses/latest/APIReference-V2/API_Template.html)
    /// but not in `BulkEmailEntry`, the header
    /// from `Template` will be added to the outgoing email.
    ///
    /// * Headers Present in `BulkEmailEntry`: If a header is specified in
    /// `BulkEmailEntry`, it takes precedence over any header of the same name
    /// specified
    /// in [
    /// `Template`
    /// ](https://docs.aws.amazon.com/ses/latest/APIReference-V2/API_Template.html):
    ///
    /// * If the header is also defined within `Template`,
    /// the value from `BulkEmailEntry` will replace the header's
    /// value in the email.
    ///
    /// * If the header is not defined within `Template`,
    /// it will simply be added to the email as specified in
    /// `BulkEmailEntry`.
    replacement_headers: ?[]const MessageHeader = null,

    /// A list of tags, in the form of name/value pairs, to apply to an email that
    /// you send
    /// using the `SendBulkTemplatedEmail` operation. Tags correspond to
    /// characteristics of the email that you define, so that you can publish email
    /// sending
    /// events.
    replacement_tags: ?[]const MessageTag = null,

    pub const json_field_names = .{
        .destination = "Destination",
        .replacement_email_content = "ReplacementEmailContent",
        .replacement_headers = "ReplacementHeaders",
        .replacement_tags = "ReplacementTags",
    };
};
