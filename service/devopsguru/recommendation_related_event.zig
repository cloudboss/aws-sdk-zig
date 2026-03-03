const RecommendationRelatedEventResource = @import("recommendation_related_event_resource.zig").RecommendationRelatedEventResource;

/// Information about an event that is related to a recommendation.
pub const RecommendationRelatedEvent = struct {
    /// The name of the event. This corresponds to the `Name` field in an
    /// `Event` object.
    name: ?[]const u8 = null,

    /// A `ResourceCollection` object that contains arrays of the names of Amazon
    /// Web Services
    /// CloudFormation stacks. You can specify up to 500 Amazon Web Services
    /// CloudFormation stacks.
    resources: ?[]const RecommendationRelatedEventResource = null,

    pub const json_field_names = .{
        .name = "Name",
        .resources = "Resources",
    };
};
