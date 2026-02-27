/// Specifies the subject or body of an email message, represented as textual
/// email data and the applicable character set.
pub const SimpleEmailPart = struct {
    /// The applicable character set for the message content.
    charset: ?[]const u8,

    /// The textual data of the message content.
    data: ?[]const u8,

    pub const json_field_names = .{
        .charset = "Charset",
        .data = "Data",
    };
};
