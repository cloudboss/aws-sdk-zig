/// A result item for a document with a new relevancy score.
pub const RescoreResultItem = struct {
    /// The identifier of the document from the search service.
    document_id: ?[]const u8 = null,

    /// The relevancy score or rank that Amazon Kendra
    /// Intelligent Ranking gives to the result.
    score: ?f32 = null,

    pub const json_field_names = .{
        .document_id = "DocumentId",
        .score = "Score",
    };
};
