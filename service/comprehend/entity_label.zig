const PiiEntityType = @import("pii_entity_type.zig").PiiEntityType;

/// Specifies one of the label or labels that categorize the personally
/// identifiable
/// information (PII) entity being analyzed.
pub const EntityLabel = struct {
    /// The name of the label.
    name: ?PiiEntityType = null,

    /// The level of confidence that Amazon Comprehend has in the accuracy of the
    /// detection.
    score: ?f32 = null,

    pub const json_field_names = .{
        .name = "Name",
        .score = "Score",
    };
};
