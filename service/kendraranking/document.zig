/// Information about a document from a search service such
/// as OpenSearch (self managed). Amazon Kendra Intelligent
/// Ranking uses this information to rank and score on.
pub const Document = struct {
    /// The body text of the search service's document.
    body: ?[]const u8 = null,

    /// The optional group identifier of the document from the search
    /// service. Documents with the same group identifier are grouped
    /// together and processed as one document within the service.
    group_id: ?[]const u8 = null,

    /// The identifier of the document from the search service.
    id: []const u8,

    /// The original document score or rank from the search service.
    /// Amazon Kendra Intelligent Ranking gives the document a new
    /// score or rank based on its intelligent search algorithms.
    original_score: f32,

    /// The title of the search service's document.
    title: ?[]const u8 = null,

    /// The body text of the search service's document represented
    /// as a list of tokens or words. You must choose to provide
    /// `Body` or `TokenizedBody`. You cannot
    /// provide both.
    tokenized_body: ?[]const []const u8 = null,

    /// The title of the search service's document represented as
    /// a list of tokens or words. You must choose to provide
    /// `Title` or `TokenizedTitle`. You cannot
    /// provide both.
    tokenized_title: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .body = "Body",
        .group_id = "GroupId",
        .id = "Id",
        .original_score = "OriginalScore",
        .title = "Title",
        .tokenized_body = "TokenizedBody",
        .tokenized_title = "TokenizedTitle",
    };
};
