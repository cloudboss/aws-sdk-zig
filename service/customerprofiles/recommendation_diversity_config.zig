const aws = @import("aws");

/// Runtime diversity configuration for a `GetProfileRecommendations` request.
pub const RecommendationDiversityConfig = struct {
    /// Whether diversity-aware recommendations are enabled for this request.
    enabled: bool,

    /// An optional map of placeholder name to integer cap value used to resolve
    /// `$name` placeholders defined in the recommender's `DiversityConfig` at
    /// inference time. Up to 2 entries are supported.
    values: ?[]const aws.map.MapEntry(i32) = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .values = "Values",
    };
};
