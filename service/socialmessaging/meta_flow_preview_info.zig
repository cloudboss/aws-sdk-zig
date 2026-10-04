/// Contains the preview URL for testing a WhatsApp Flow and its expiration
/// timestamp.
pub const MetaFlowPreviewInfo = struct {
    /// The timestamp when the preview URL expires.
    expires_at: []const u8,

    /// The web URL for previewing the Flow. Can be shared with stakeholders for
    /// review.
    preview_url: []const u8,

    pub const json_field_names = .{
        .expires_at = "expiresAt",
        .preview_url = "previewUrl",
    };
};
