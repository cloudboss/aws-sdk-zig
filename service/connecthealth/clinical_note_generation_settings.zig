const NoteTemplateSettings = @import("note_template_settings.zig").NoteTemplateSettings;

/// Settings for generating clinical notes from the audio stream
pub const ClinicalNoteGenerationSettings = struct {
    /// Settings for the note template to use
    note_template_settings: NoteTemplateSettings,

    pub const json_field_names = .{
        .note_template_settings = "noteTemplateSettings",
    };
};
