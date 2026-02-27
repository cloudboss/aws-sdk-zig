const SearchRecord = @import("search_record.zig").SearchRecord;
const TotalHits = @import("total_hits.zig").TotalHits;

pub const SearchResponse = struct {
    /// If the result of the previous `Search` request was truncated, the response
    /// includes a NextToken. To retrieve the next set of results, use the token in
    /// the next request.
    next_token: ?[]const u8,

    /// A list of `SearchRecord` objects.
    results: ?[]const SearchRecord,

    /// The total number of matching results.
    total_hits: ?TotalHits,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .results = "Results",
        .total_hits = "TotalHits",
    };
};
