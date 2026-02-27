const ClinicalNoteGenerationSettings = @import("clinical_note_generation_settings.zig").ClinicalNoteGenerationSettings;

/// The settings for post-stream analytics.
pub const MedicalScribePostStreamAnalyticsSettings = struct {
    /// Specify settings for the post-stream clinical note generation.
    clinical_note_generation_settings: ClinicalNoteGenerationSettings,

    pub const json_field_names = .{
        .clinical_note_generation_settings = "ClinicalNoteGenerationSettings",
    };
};
