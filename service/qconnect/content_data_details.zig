const RankingData = @import("ranking_data.zig").RankingData;
const TextData = @import("text_data.zig").TextData;

/// Details about the content data.
pub const ContentDataDetails = struct {
    /// Details about the content ranking data.
    ranking_data: RankingData,

    /// Details about the content text data.
    text_data: TextData,

    pub const json_field_names = .{
        .ranking_data = "rankingData",
        .text_data = "textData",
    };
};
