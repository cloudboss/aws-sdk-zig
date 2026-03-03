/// The ICD-10-CM concepts that the entity could refer to, along with a score
/// indicating the
/// likelihood of the match.
pub const ICD10CMConcept = struct {
    /// The ICD-10-CM code that identifies the concept found in the knowledge base
    /// from the
    /// Centers for Disease Control.
    code: ?[]const u8 = null,

    /// The long description of the ICD-10-CM code in the ontology.
    description: ?[]const u8 = null,

    /// The level of confidence that Amazon Comprehend Medical has that the entity
    /// is accurately
    /// linked to an ICD-10-CM concept.
    score: ?f32 = null,

    pub const json_field_names = .{
        .code = "Code",
        .description = "Description",
        .score = "Score",
    };
};
