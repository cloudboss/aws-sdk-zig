const RankingData = @import("ranking_data.zig").RankingData;
const DataSummary = @import("data_summary.zig").DataSummary;

/// Details about generative data.
pub const GenerativeDataDetails = struct {
    /// The LLM response.
    completion: []const u8,

    /// Details about the generative content ranking data.
    ranking_data: RankingData,

    /// The references used to generative the LLM response.
    references: []const DataSummary,

    pub const json_field_names = .{
        .completion = "completion",
        .ranking_data = "rankingData",
        .references = "references",
    };
};
