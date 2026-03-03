const CitationSpan = @import("citation_span.zig").CitationSpan;
const RankingData = @import("ranking_data.zig").RankingData;
const TextData = @import("text_data.zig").TextData;
const SourceContentType = @import("source_content_type.zig").SourceContentType;

/// Details about the source content data.
pub const SourceContentDataDetails = struct {
    /// Contains information about where the text with a citation begins and ends in
    /// the generated output.
    citation_span: ?CitationSpan = null,

    /// The identifier of the source content.
    id: []const u8,

    /// Details about the source content ranking data.
    ranking_data: RankingData,

    /// Details about the source content text data.
    text_data: TextData,

    /// The type of the source content.
    @"type": SourceContentType,

    pub const json_field_names = .{
        .citation_span = "citationSpan",
        .id = "id",
        .ranking_data = "rankingData",
        .text_data = "textData",
        .@"type" = "type",
    };
};
