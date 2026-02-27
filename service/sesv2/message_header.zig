/// Contains the name and value of a message header that you add to an email.
pub const MessageHeader = struct {
    /// The name of the message header. The message header name has to meet the
    /// following
    /// criteria:
    ///
    /// * Can contain any printable ASCII character (33 - 126) except for colon (:).
    ///
    /// * Can contain no more than 126 characters.
    name: []const u8,

    /// The value of the message header. The message header value has to meet the
    /// following
    /// criteria:
    ///
    /// * Can contain any printable ASCII character.
    ///
    /// * Can contain no more than 870 characters.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
