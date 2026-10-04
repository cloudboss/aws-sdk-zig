const RetrievalFilter = @import("retrieval_filter.zig").RetrievalFilter;

/// Overrides for retrieval behavior.
pub const RetrievalOverrides = struct {
    /// A filter to apply to the retrieval results.
    filter: ?RetrievalFilter = null,

    /// The maximum number of results to return.
    max_number_of_results: ?i32 = null,

    pub const json_field_names = .{
        .filter = "filter",
        .max_number_of_results = "maxNumberOfResults",
    };
};
