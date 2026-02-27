/// Specifies the contents of an email message, represented as a raw MIME
/// message.
pub const RawEmail = struct {
    /// The email message, represented as a raw MIME message. The entire message
    /// must be base64 encoded.
    data: ?[]const u8,

    pub const json_field_names = .{
        .data = "Data",
    };
};
