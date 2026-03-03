/// Container for user interface template information.
pub const UiTemplateInfo = struct {
    /// The SHA-256 digest of the contents of the template.
    content_sha_256: ?[]const u8 = null,

    /// The URL for the user interface template.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_sha_256 = "ContentSha256",
        .url = "Url",
    };
};
