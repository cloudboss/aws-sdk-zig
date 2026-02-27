/// Configuration settings for enabling and controlling document citations in
/// Converse API responses. When enabled, the model can include citation
/// information that links generated content back to specific source documents.
pub const CitationsConfig = struct {
    /// Specifies whether citations from the selected document should be used in the
    /// model's response. When set to true, the model can generate citations that
    /// reference the source documents used to inform the response.
    enabled: bool,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
