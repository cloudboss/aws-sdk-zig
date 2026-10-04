const InsightFeedbackEntityType = @import("insight_feedback_entity_type.zig").InsightFeedbackEntityType;

/// Specifies the entity for which to submit insight feedback. An entity
/// represents an
/// Amazon OpenSearch Service domain.
pub const InsightFeedbackEntity = struct {
    /// The type of the entity. Possible values are `DomainName`.
    @"type": InsightFeedbackEntityType,

    /// The value of the entity, such as a domain name.
    value: []const u8,

    pub const json_field_names = .{
        .@"type" = "Type",
        .value = "Value",
    };
};
