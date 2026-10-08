const ClinicalNoteGenerationResult = @import("clinical_note_generation_result.zig").ClinicalNoteGenerationResult;

/// Results of post-stream actions performed after the audio stream ended
pub const MedicalScribePostStreamActionsResult = struct {
    /// Results of clinical note generation
    clinical_note_generation_result: ?ClinicalNoteGenerationResult = null,

    pub const json_field_names = .{
        .clinical_note_generation_result = "clinicalNoteGenerationResult",
    };
};
