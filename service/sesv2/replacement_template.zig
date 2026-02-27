/// An object which contains `ReplacementTemplateData` to be used for a
/// specific `BulkEmailEntry`.
pub const ReplacementTemplate = struct {
    /// A list of replacement values to apply to the template. This parameter is a
    /// JSON
    /// object, typically consisting of key-value pairs in which the keys correspond
    /// to
    /// replacement tags in the email template.
    replacement_template_data: ?[]const u8,

    pub const json_field_names = .{
        .replacement_template_data = "ReplacementTemplateData",
    };
};
