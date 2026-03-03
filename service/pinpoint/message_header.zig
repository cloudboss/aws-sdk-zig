/// Contains the name and value pair of an email header to add to your email.
/// You can have up to 15 MessageHeaders. A header can contain information such
/// as the sender, receiver, route, or timestamp.
pub const MessageHeader = struct {
    /// The name of the message header. The header name can contain up to 126
    /// characters.
    name: ?[]const u8 = null,

    /// The value of the message header. The header value can contain up to 870
    /// characters, including the length of any rendered attributes. For example if
    /// you add the {CreationDate} attribute, it renders as YYYY-MM-DDTHH:MM:SS.SSSZ
    /// and is 24 characters in length.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
