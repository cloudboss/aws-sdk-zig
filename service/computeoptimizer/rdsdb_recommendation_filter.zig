const RDSDBRecommendationFilterName = @import("rdsdb_recommendation_filter_name.zig").RDSDBRecommendationFilterName;

/// Describes a filter that returns a more specific list of DB instance
/// recommendations. Use this filter with the GetECSServiceRecommendations
/// action.
pub const RDSDBRecommendationFilter = struct {
    /// The name of the filter.
    ///
    /// Specify `Finding` to return recommendations with a specific finding
    /// classification.
    ///
    /// You can filter your DB instance recommendations by `tag:key`
    /// and `tag-key` tags.
    ///
    /// A `tag:key` is a key and value combination of a tag assigned to your
    /// DB instance recommendations. Use the tag key in the filter name and the tag
    /// value
    /// as the filter value. For example, to find all DB instance recommendations
    /// that have
    /// a tag with the key of `Owner` and the value of `TeamA`,
    /// specify `tag:Owner` for the filter name and `TeamA` for the filter value.
    ///
    /// A `tag-key` is the key of a tag assigned to your DB instance
    /// recommendations. Use
    /// this filter to find all of your DB instance recommendations that have a tag
    /// with a
    /// specific key. This doesn’t consider the tag value. For example, you can find
    /// your DB instance recommendations with a tag key value of `Owner` or without
    /// any tag
    /// keys assigned.
    name: ?RDSDBRecommendationFilterName = null,

    /// The value of the filter.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
