const RecommenderFilter = @import("recommender_filter.zig").RecommenderFilter;
const RecommenderPromotionalFilter = @import("recommender_promotional_filter.zig").RecommenderPromotionalFilter;

/// The recommender used to generate the recommendations.
pub const Recommender = struct {
    /// A list of filters to apply to the returned recommendations. Filters define
    /// criteria for including or excluding items from the recommendation results.
    filters: ?[]const RecommenderFilter = null,

    /// The unique name of the recommender.
    name: []const u8,

    /// A list of promotional filters to apply to the recommendations. Promotional
    /// filters allow you to promote specific items within a configurable subset of
    /// recommendation results.
    promotional_filters: ?[]const RecommenderPromotionalFilter = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .name = "Name",
        .promotional_filters = "PromotionalFilters",
    };
};
