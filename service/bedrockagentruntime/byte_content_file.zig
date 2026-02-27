/// The property contains the file to chat with, along with its attributes.
pub const ByteContentFile = struct {
    /// The raw bytes of the file to attach. The maximum size of all files that is
    /// attached is 10MB. You can attach a maximum of 5 files.
    data: []const u8,

    /// The MIME type of data contained in the file used for chat.
    media_type: []const u8,

    pub const json_field_names = .{
        .data = "data",
        .media_type = "mediaType",
    };
};
