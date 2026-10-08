const NoteTemplateSettingsResponse = @import("note_template_settings_response.zig").NoteTemplateSettingsResponse;

/// Response containing settings for clinical note generation
pub const ClinicalNoteGenerationSettingsResponse = struct {
    /// Settings for the note template used
    note_template_settings: ?NoteTemplateSettingsResponse = null,

    pub const json_field_names = .{
        .note_template_settings = "noteTemplateSettings",
    };
};
