/// The command payload object that contains the instructions for the device
/// to process.
pub const CommandPayload = struct {
    /// The static payload file for the command.
    content: ?[]const u8 = null,

    /// The content type that specifies the format type of the payload file. This
    /// field must use a type/subtype format, such as `application/json`.
    /// For information about various content types, see [Common MIME
    /// types](https://developer.mozilla.org/en-US/docs/Web/HTTP/MIME_types/Common_types).
    content_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .content = "content",
        .content_type = "contentType",
    };
};
