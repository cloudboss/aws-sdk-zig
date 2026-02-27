/// When included in a receipt rule, this action adds a header to the received
/// email.
///
/// For information about adding a header using a receipt rule, see the [Amazon
/// SES Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/receiving-email-action-add-header.html).
pub const AddHeaderAction = struct {
    /// The name of the header to add to the incoming message. The name must contain
    /// at least
    /// one character, and can contain up to 50 characters. It consists of
    /// alphanumeric (a–z,
    /// A–Z, 0–9) characters and dashes.
    header_name: []const u8,

    /// The content to include in the header. This value can contain up to 2048
    /// characters. It
    /// can't contain newline (`\n`) or carriage return (`\r`)
    /// characters.
    header_value: []const u8,
};
