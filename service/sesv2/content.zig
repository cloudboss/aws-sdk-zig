/// An object that represents the content of the email, and optionally a
/// character set
/// specification.
pub const Content = struct {
    /// The character set for the content. Because of the constraints of the SMTP
    /// protocol,
    /// Amazon SES uses 7-bit ASCII by default. If the text includes characters
    /// outside of the ASCII
    /// range, you have to specify a character set. For example, you could specify
    /// `UTF-8`, `ISO-8859-1`, or `Shift_JIS`.
    charset: ?[]const u8,

    /// The content of the message itself.
    data: []const u8,

    pub const json_field_names = .{
        .charset = "Charset",
        .data = "Data",
    };
};
