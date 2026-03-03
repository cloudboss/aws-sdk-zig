const EBSFilterName = @import("ebs_filter_name.zig").EBSFilterName;

/// Describes a filter that returns a more specific list of Amazon Elastic Block
/// Store
/// (Amazon EBS) volume recommendations. Use this filter with the
/// GetEBSVolumeRecommendations action.
///
/// You can use `LambdaFunctionRecommendationFilter` with the
/// GetLambdaFunctionRecommendations action, `JobFilter` with the
/// DescribeRecommendationExportJobs action, and `Filter`
/// with the GetAutoScalingGroupRecommendations and
/// GetEC2InstanceRecommendations actions.
pub const EBSFilter = struct {
    /// The name of the filter.
    ///
    /// Specify `Finding` to return recommendations with a specific finding
    /// classification (for example, `NotOptimized`).
    ///
    /// You can filter your Amazon EBS volume recommendations by `tag:key`
    /// and `tag-key` tags.
    ///
    /// A `tag:key` is a key and value combination of a tag assigned to your
    /// Amazon EBS volume recommendations. Use the tag key in the filter name and
    /// the tag value
    /// as the filter value. For example, to find all Amazon EBS volume
    /// recommendations that have
    /// a tag with the key of `Owner` and the value of `TeamA`,
    /// specify `tag:Owner` for the filter name and `TeamA` for the filter value.
    ///
    /// A `tag-key` is the key of a tag assigned to your Amazon EBS volume
    /// recommendations. Use
    /// this filter to find all of your Amazon EBS volume recommendations that have
    /// a tag with a
    /// specific key. This doesn’t consider the tag value. For example, you can find
    /// your Amazon EBS volume recommendations with a tag key value of `Owner` or
    /// without any tag
    /// keys assigned.
    name: ?EBSFilterName = null,

    /// The value of the filter.
    ///
    /// The valid values are `Optimized`, or `NotOptimized`.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
