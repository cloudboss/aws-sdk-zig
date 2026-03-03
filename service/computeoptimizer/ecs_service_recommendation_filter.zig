const ECSServiceRecommendationFilterName = @import("ecs_service_recommendation_filter_name.zig").ECSServiceRecommendationFilterName;

/// Describes a filter that returns a more specific list of Amazon ECS service
/// recommendations. Use this filter with the GetECSServiceRecommendations
/// action.
pub const ECSServiceRecommendationFilter = struct {
    /// The name of the filter.
    ///
    /// Specify `Finding` to return recommendations with a specific finding
    /// classification.
    ///
    /// Specify `FindingReasonCode` to return recommendations with a specific
    /// finding reason code.
    ///
    /// You can filter your Amazon ECS service recommendations by `tag:key`
    /// and `tag-key` tags.
    ///
    /// A `tag:key` is a key and value combination of a tag assigned to your
    /// Amazon ECS service recommendations. Use the tag key in the filter name and
    /// the tag value
    /// as the filter value. For example, to find all Amazon ECS service
    /// recommendations that have
    /// a tag with the key of `Owner` and the value of `TeamA`,
    /// specify `tag:Owner` for the filter name and `TeamA` for the filter value.
    ///
    /// A `tag-key` is the key of a tag assigned to your Amazon ECS service
    /// recommendations. Use
    /// this filter to find all of your Amazon ECS service recommendations that have
    /// a tag with a
    /// specific key. This doesn’t consider the tag value. For example, you can find
    /// your Amazon ECS service recommendations with a tag key value of `Owner` or
    /// without any tag
    /// keys assigned.
    name: ?ECSServiceRecommendationFilterName = null,

    /// The value of the filter.
    ///
    /// The valid values for this parameter are as follows:
    ///
    /// * If you specify the `name` parameter as `Finding`, specify
    /// `Optimized`, `Underprovisioned`, or `Overprovisioned`.
    ///
    /// * If you specify the `name` parameter as `FindingReasonCode`, specify
    /// `CPUUnderprovisioned`, `CPUOverprovisioned`,
    /// `MemoryUnderprovisioned`, or `MemoryOverprovisioned`.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
