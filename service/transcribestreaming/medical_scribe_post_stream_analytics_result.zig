const ClinicalNoteGenerationResult = @import("clinical_note_generation_result.zig").ClinicalNoteGenerationResult;

/// Contains details for the result of post-stream analytics.
pub const MedicalScribePostStreamAnalyticsResult = struct {
    /// Provides the Clinical Note Generation result for post-stream analytics.
    clinical_note_generation_result: ?ClinicalNoteGenerationResult,

    pub const json_field_names = .{
        .clinical_note_generation_result = "ClinicalNoteGenerationResult",
    };
};
