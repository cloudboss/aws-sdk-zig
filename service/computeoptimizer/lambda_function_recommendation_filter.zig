const LambdaFunctionRecommendationFilterName = @import("lambda_function_recommendation_filter_name.zig").LambdaFunctionRecommendationFilterName;

/// Describes a filter that returns a more specific list of Lambda
/// function recommendations. Use this filter with the
/// GetLambdaFunctionRecommendations action.
///
/// You can use `EBSFilter` with the GetEBSVolumeRecommendations action,
/// `JobFilter` with the
/// DescribeRecommendationExportJobs action, and `Filter`
/// with the GetAutoScalingGroupRecommendations and
/// GetEC2InstanceRecommendations actions.
pub const LambdaFunctionRecommendationFilter = struct {
    /// The name of the filter.
    ///
    /// Specify `Finding` to return recommendations with a specific finding
    /// classification (for example, `NotOptimized`).
    ///
    /// Specify `FindingReasonCode` to return recommendations with a specific
    /// finding reason code (for example, `MemoryUnderprovisioned`).
    ///
    /// You can filter your Lambda function recommendations by `tag:key`
    /// and `tag-key` tags.
    ///
    /// A `tag:key` is a key and value combination of a tag assigned to your
    /// Lambda function recommendations. Use the tag key in the filter name and the
    /// tag value
    /// as the filter value. For example, to find all Lambda function
    /// recommendations that have
    /// a tag with the key of `Owner` and the value of `TeamA`,
    /// specify `tag:Owner` for the filter name and `TeamA` for the filter value.
    ///
    /// A `tag-key` is the key of a tag assigned to your Lambda function
    /// recommendations. Use
    /// this filter to find all of your Lambda function recommendations that have a
    /// tag with a
    /// specific key. This doesn’t consider the tag value. For example, you can find
    /// your Lambda function recommendations with a tag key value of `Owner` or
    /// without any tag
    /// keys assigned.
    name: ?LambdaFunctionRecommendationFilterName,

    /// The value of the filter.
    ///
    /// The valid values for this parameter are as follows, depending on what you
    /// specify for
    /// the `name` parameter:
    ///
    /// * Specify `Optimized`, `NotOptimized`, or
    /// `Unavailable` if you specify the `name` parameter as
    /// `Finding`.
    ///
    /// * Specify `MemoryOverprovisioned`,
    /// `MemoryUnderprovisioned`, `InsufficientData`, or
    /// `Inconclusive` if you specify the `name` parameter as
    /// `FindingReasonCode`.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
