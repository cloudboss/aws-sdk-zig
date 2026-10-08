const InsightsCategory = @import("insights_category.zig").InsightsCategory;

/// Contains a single insight about a service's dependencies.
pub const DependencyInsight = struct {
    /// The category of the insight. Valid values:
    ///
    /// * CROSS_REGION - The insight relates to dependencies used across multiple
    ///   Regions.
    /// * NEW_DEPENDENCY - The insight relates to a recently detected dependency.
    /// * THIRD_PARTY - The insight relates to a third-party dependency.
    /// * UNEVEN_USAGE - The insight relates to a dependency with uneven usage
    ///   across the service.
    /// * AWS_SERVICE - The insight relates to a dependency on an Amazon Web
    ///   Services service.
    category: InsightsCategory,

    /// A human-readable explanation of the insight, describing the dependency
    /// behavior or condition that was detected.
    description: []const u8,

    pub const json_field_names = .{
        .category = "category",
        .description = "description",
    };
};
