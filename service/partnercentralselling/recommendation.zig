const aws = @import("aws");

/// A recommendation from an agent-driven source.
pub const Recommendation = struct {
    /// Source-specific metadata as key-value pairs.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// Human-readable recommendation text from this source.
    details: []const u8,

    /// The recommendation source type. Known values: `OpportunityQuality`,
    /// `SolutionRecommendation`, `SpecialistRecommendation`.
    @"type": []const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .details = "Details",
        .@"type" = "Type",
    };
};
