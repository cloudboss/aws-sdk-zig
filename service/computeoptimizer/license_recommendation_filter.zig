const LicenseRecommendationFilterName = @import("license_recommendation_filter_name.zig").LicenseRecommendationFilterName;

/// Describes a filter that returns a more specific list of license
/// recommendations. Use this filter
/// with the `GetLicenseRecommendation` action.
pub const LicenseRecommendationFilter = struct {
    /// The name of the filter.
    ///
    /// Specify `Finding` to return recommendations with a specific finding
    /// classification.
    ///
    /// Specify `FindingReasonCode` to return recommendations with a specific
    /// finding reason code.
    ///
    /// You can filter your license recommendations by `tag:key`
    /// and `tag-key` tags.
    ///
    /// A `tag:key` is a key and value combination of a tag assigned to your
    /// license recommendations. Use the tag key in the filter name and the tag
    /// value
    /// as the filter value. For example, to find all license recommendations that
    /// have
    /// a tag with the key of `Owner` and the value of `TeamA`,
    /// specify `tag:Owner` for the filter name and `TeamA` for the filter value.
    ///
    /// A `tag-key` is the key of a tag assigned to your license recommendations.
    /// Use
    /// this filter to find all of your license recommendations that have a tag with
    /// a
    /// specific key. This doesn’t consider the tag value. For example, you can find
    /// your license recommendations with a tag key value of `Owner` or without any
    /// tag
    /// keys assigned.
    name: ?LicenseRecommendationFilterName,

    /// The value of the filter.
    ///
    /// The valid values for this parameter are as follows, depending on what you
    /// specify for
    /// the `name` parameter:
    ///
    /// * If you specify the `name` parameter as
    /// `Finding`, then specify `Optimized`, `NotOptimized`, or
    /// `InsufficentMetrics`.
    ///
    /// * If you specify the `name` parameter as
    /// `FindingReasonCode`, then specify `Optimized`,
    /// `LicenseOverprovisioned`, `InvalidCloudwatchApplicationInsights`, or
    /// `CloudwatchApplicationInsightsError`.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
