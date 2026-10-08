const ClinicalNoteGenerationSettingsResponse = @import("clinical_note_generation_settings_response.zig").ClinicalNoteGenerationSettingsResponse;

/// Response containing settings for post-stream actions
pub const MedicalScribePostStreamActionSettingsResponse = struct {
    /// Settings for clinical note generation
    clinical_note_generation_settings: ClinicalNoteGenerationSettingsResponse,

    output_s3_uri: []const u8,

    pub const json_field_names = .{
        .clinical_note_generation_settings = "clinicalNoteGenerationSettings",
        .output_s3_uri = "outputS3Uri",
    };
};
