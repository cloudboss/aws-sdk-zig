/// The request entry for Recommendation Resource exclusion. Each entry is a
/// combination of Recommendation Resource ARN and corresponding exclusion
/// status
pub const RecommendationResourceExclusion = struct {
    /// The ARN of the Recommendation Resource
    arn: []const u8,

    /// The exclusion status
    is_excluded: bool,

    pub const json_field_names = .{
        .arn = "arn",
        .is_excluded = "isExcluded",
    };
};
