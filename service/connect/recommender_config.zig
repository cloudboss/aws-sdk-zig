const aws = @import("aws");

/// Configuration for the recommender used to generate personalized
/// recommendations included in an outbound web
/// notification.
pub const RecommenderConfig = struct {
    /// A map of contextual key-value pairs supplied to the recommender to influence
    /// the recommendations
    /// returned.
    context: ?[]const aws.map.StringMapEntry = null,

    /// The name of the Amazon Personalize domain that hosts the recommender.
    domain_name: []const u8,

    /// The name of the recommender used to generate the recommendations.
    recommender_name: []const u8,

    pub const json_field_names = .{
        .context = "Context",
        .domain_name = "DomainName",
        .recommender_name = "RecommenderName",
    };
};
