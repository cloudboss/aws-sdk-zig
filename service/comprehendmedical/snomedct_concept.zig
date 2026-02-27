/// The SNOMED-CT concepts that the entity could refer to, along with a score
/// indicating the likelihood of the match.
pub const SNOMEDCTConcept = struct {
    /// The numeric ID for the SNOMED-CT concept.
    code: ?[]const u8,

    /// The description of the SNOMED-CT concept.
    description: ?[]const u8,

    /// The level of confidence Amazon Comprehend Medical has that the entity should
    /// be linked to the identified SNOMED-CT concept.
    score: ?f32,

    pub const json_field_names = .{
        .code = "Code",
        .description = "Description",
        .score = "Score",
    };
};
