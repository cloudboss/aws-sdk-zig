const RecommendationRelatedAnomaly = @import("recommendation_related_anomaly.zig").RecommendationRelatedAnomaly;
const RecommendationRelatedEvent = @import("recommendation_related_event.zig").RecommendationRelatedEvent;

/// Recommendation information to help you remediate detected anomalous behavior
/// that
/// generated an insight.
pub const Recommendation = struct {
    /// The category type of the recommendation.
    category: ?[]const u8,

    /// A description of the problem.
    description: ?[]const u8,

    /// A hyperlink to information to help you address the problem.
    link: ?[]const u8,

    /// The name of the recommendation.
    name: ?[]const u8,

    /// The reason DevOps Guru flagged the anomalous behavior as a problem.
    reason: ?[]const u8,

    /// Anomalies that are related to the problem. Use these Anomalies to learn more
    /// about
    /// what's happening and to help address the issue.
    related_anomalies: ?[]const RecommendationRelatedAnomaly,

    /// Events that are related to the problem. Use these events to learn more about
    /// what's
    /// happening and to help address the issue.
    related_events: ?[]const RecommendationRelatedEvent,

    pub const json_field_names = .{
        .category = "Category",
        .description = "Description",
        .link = "Link",
        .name = "Name",
        .reason = "Reason",
        .related_anomalies = "RelatedAnomalies",
        .related_events = "RelatedEvents",
    };
};
