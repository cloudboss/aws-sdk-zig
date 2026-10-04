const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;

/// A single matching segment of time-series data returned by a search.
pub const SearchResult = struct {
    /// The identifier of the dataset that contains the matching data.
    dataset_id: []const u8,

    /// The end of the matching time-series segment, in nanoseconds since the Unix
    /// epoch.
    end_timestamp: TimeInNanos,

    /// The relevance score of this result. Higher scores indicate a stronger match.
    score: f32,

    /// The identifier of the search that produced this result.
    search_id: []const u8,

    /// The start of the matching time-series segment, in nanoseconds since the Unix
    /// epoch.
    start_timestamp: TimeInNanos,

    /// The identifier of the time series that contains the matching data.
    time_series_id: []const u8,

    /// The timestamp of the most relevant point within the matching segment, in
    /// nanoseconds since the
    /// Unix epoch.
    top_timestamp: TimeInNanos,

    /// The name of the workspace the search ran against.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
        .end_timestamp = "endTimestamp",
        .score = "score",
        .search_id = "searchId",
        .start_timestamp = "startTimestamp",
        .time_series_id = "timeSeriesId",
        .top_timestamp = "topTimestamp",
        .workspace_name = "workspaceName",
    };
};
