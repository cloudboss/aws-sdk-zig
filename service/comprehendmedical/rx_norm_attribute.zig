const RxNormTrait = @import("rx_norm_trait.zig").RxNormTrait;
const RxNormAttributeType = @import("rx_norm_attribute_type.zig").RxNormAttributeType;

/// The extracted attributes that relate to this entity. The attributes
/// recognized by
/// InferRxNorm are `DOSAGE`, `DURATION`, `FORM`,
/// `FREQUENCY`, `RATE`, `ROUTE_OR_MODE`.
pub const RxNormAttribute = struct {
    /// The 0-based character offset in the input text that shows where the
    /// attribute begins. The
    /// offset returns the UTF-8 code point in the string.
    begin_offset: ?i32,

    /// The 0-based character offset in the input text that shows where the
    /// attribute ends. The
    /// offset returns the UTF-8 code point in the string.
    end_offset: ?i32,

    /// The numeric identifier for this attribute. This is a monotonically
    /// increasing id unique
    /// within this response rather than a global unique identifier.
    id: ?i32,

    /// The level of confidence that Amazon Comprehend Medical has that the
    /// attribute is
    /// accurately linked to an entity.
    relationship_score: ?f32,

    /// The level of confidence that Amazon Comprehend Medical has that the segment
    /// of text is correctly
    /// recognized as an attribute.
    score: ?f32,

    /// The segment of input text which corresponds to the detected attribute.
    text: ?[]const u8,

    /// Contextual information for the attribute. InferRxNorm recognizes the trait
    /// `NEGATION` for attributes, i.e. that the patient is not taking a specific
    /// dose or
    /// form of a medication.
    traits: ?[]const RxNormTrait,

    /// The type of attribute. The types of attributes recognized by InferRxNorm are
    /// `BRAND_NAME` and `GENERIC_NAME`.
    type: ?RxNormAttributeType,

    pub const json_field_names = .{
        .begin_offset = "BeginOffset",
        .end_offset = "EndOffset",
        .id = "Id",
        .relationship_score = "RelationshipScore",
        .score = "Score",
        .text = "Text",
        .traits = "Traits",
        .type = "Type",
    };
};
