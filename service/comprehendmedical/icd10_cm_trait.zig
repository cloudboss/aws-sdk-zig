const ICD10CMTraitName = @import("icd10_cm_trait_name.zig").ICD10CMTraitName;

/// Contextual information for the entity. The traits recognized by InferICD10CM
/// are
/// `DIAGNOSIS`, `SIGN`, `SYMPTOM`, and
/// `NEGATION`.
pub const ICD10CMTrait = struct {
    /// Provides a name or contextual description about the trait.
    name: ?ICD10CMTraitName = null,

    /// The level of confidence that Amazon Comprehend Medical has that the segment
    /// of text is correctly recognized
    /// as a trait.
    score: ?f32 = null,

    pub const json_field_names = .{
        .name = "Name",
        .score = "Score",
    };
};
