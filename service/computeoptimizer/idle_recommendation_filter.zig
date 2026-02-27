const IdleRecommendationFilterName = @import("idle_recommendation_filter_name.zig").IdleRecommendationFilterName;

/// Describes a filter that returns a more specific list of idle resource
/// recommendations.
pub const IdleRecommendationFilter = struct {
    /// The name of the filter.
    ///
    /// Specify `Finding` to return recommendations with a specific finding
    /// classification.
    ///
    /// You can filter your idle resource recommendations by `tag:key`
    /// and `tag-key` tags.
    ///
    /// A `tag:key` is a key and value combination of a tag assigned to your
    /// idle resource recommendations. Use the tag key in the filter name and the
    /// tag value
    /// as the filter value. For example, to find all idle resource service
    /// recommendations that have
    /// a tag with the key of `Owner` and the value of `TeamA`,
    /// specify `tag:Owner` for the filter name and `TeamA` for the filter value.
    ///
    /// A `tag-key` is the key of a tag assigned to your idle resource
    /// recommendations. Use
    /// this filter to find all of your idle resource recommendations that have a
    /// tag with a
    /// specific key. This doesn’t consider the tag value. For example, you can find
    /// your idle resource service recommendations with a tag key value of `Owner`
    /// or without any tag
    /// keys assigned.
    name: ?IdleRecommendationFilterName,

    /// The value of the filter.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
