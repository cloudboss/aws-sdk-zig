/// The RxNorm concept that the entity could refer to, along with a score
/// indicating the
/// likelihood of the match.
pub const RxNormConcept = struct {
    /// RxNorm concept ID, also known as the RxCUI.
    code: ?[]const u8,

    /// The description of the RxNorm concept.
    description: ?[]const u8,

    /// The level of confidence that Amazon Comprehend Medical has that the entity
    /// is accurately
    /// linked to the reported RxNorm concept.
    score: ?f32,

    pub const json_field_names = .{
        .code = "Code",
        .description = "Description",
        .score = "Score",
    };
};
