const Attribute = @import("attribute.zig").Attribute;
const EntityType = @import("entity_type.zig").EntityType;

/// An attribute that was extracted, but Amazon Comprehend Medical was unable to
/// relate to an entity.
pub const UnmappedAttribute = struct {
    /// The specific attribute that has been extracted but not mapped to an entity.
    attribute: ?Attribute,

    /// The type of the unmapped attribute, could be one of the following values:
    /// "MEDICATION",
    /// "MEDICAL_CONDITION", "ANATOMY", "TEST_AND_TREATMENT_PROCEDURE" or
    /// "PROTECTED_HEALTH_INFORMATION".
    type: ?EntityType,

    pub const json_field_names = .{
        .attribute = "Attribute",
        .type = "Type",
    };
};
