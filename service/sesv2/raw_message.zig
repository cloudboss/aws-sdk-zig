/// Represents the raw content of an email message.
pub const RawMessage = struct {
    /// The raw email message. The message has to meet the following criteria:
    ///
    /// * The message has to contain a header and a body, separated by one blank
    /// line.
    ///
    /// * All of the required header fields must be present in the message.
    ///
    /// * Each part of a multipart MIME message must be formatted properly.
    ///
    /// * Attachments must be in a file format that the Amazon SES supports.
    ///
    /// * The raw data of the message needs to base64-encoded if you are accessing
    ///   Amazon SES
    /// directly through the HTTPS interface. If you are accessing Amazon SES using
    /// an Amazon Web Services
    /// SDK, the SDK takes care of the base 64-encoding for you.
    ///
    /// * If any of the MIME parts in your message contain content that is outside
    ///   of
    /// the 7-bit ASCII character range, you should encode that content to ensure
    /// that
    /// recipients' email clients render the message properly.
    ///
    /// * The length of any single line of text in the message can't exceed 1,000
    /// characters. This restriction is defined in [RFC
    /// 5321](https://tools.ietf.org/html/rfc5321).
    data: []const u8,

    pub const json_field_names = .{
        .data = "Data",
    };
};
