/// Provides a summary of a WhatsApp message template's key attributes.
pub const TemplateSummary = struct {
    /// The numeric ID assigned to the template by Meta.
    meta_template_id: ?[]const u8,

    /// The category of the template (for example, UTILITY or MARKETING).
    template_category: ?[]const u8,

    /// The language code of the template (for example, en_US).
    template_language: ?[]const u8,

    /// The name of the template.
    template_name: ?[]const u8,

    /// The quality score assigned to the template by Meta.
    template_quality_score: ?[]const u8,

    /// The current status of the template (for example, APPROVED, PENDING, or
    /// REJECTED).
    template_status: ?[]const u8,

    pub const json_field_names = .{
        .meta_template_id = "metaTemplateId",
        .template_category = "templateCategory",
        .template_language = "templateLanguage",
        .template_name = "templateName",
        .template_quality_score = "templateQualityScore",
        .template_status = "templateStatus",
    };
};
