const ClinicalNoteGenerationSettings = @import("clinical_note_generation_settings.zig").ClinicalNoteGenerationSettings;

/// Settings for actions to perform after the audio stream ends
pub const MedicalScribePostStreamActionSettings = struct {
    /// Settings for clinical note generation
    clinical_note_generation_settings: ClinicalNoteGenerationSettings,

    output_s3_uri: []const u8,

    pub const json_field_names = .{
        .clinical_note_generation_settings = "clinicalNoteGenerationSettings",
        .output_s3_uri = "outputS3Uri",
    };
};
