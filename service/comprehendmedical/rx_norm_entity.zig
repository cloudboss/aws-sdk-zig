const RxNormAttribute = @import("rx_norm_attribute.zig").RxNormAttribute;
const RxNormEntityCategory = @import("rx_norm_entity_category.zig").RxNormEntityCategory;
const RxNormConcept = @import("rx_norm_concept.zig").RxNormConcept;
const RxNormTrait = @import("rx_norm_trait.zig").RxNormTrait;
const RxNormEntityType = @import("rx_norm_entity_type.zig").RxNormEntityType;

/// The collection of medical entities extracted from the input text and their
/// associated
/// information. For each entity, the response provides the entity text, the
/// entity category,
/// where the entity text begins and ends, and the level of confidence that
/// Amazon Comprehend
/// Medical has in the detection and analysis. Attributes and traits of the
/// entity are also
/// returned.
pub const RxNormEntity = struct {
    /// The extracted attributes that relate to the entity. The attributes
    /// recognized by
    /// InferRxNorm are `DOSAGE`, `DURATION`, `FORM`,
    /// `FREQUENCY`, `RATE`, `ROUTE_OR_MODE`, and
    /// `STRENGTH`.
    attributes: ?[]const RxNormAttribute = null,

    /// The 0-based character offset in the input text that shows where the entity
    /// begins. The
    /// offset returns the UTF-8 code point in the string.
    begin_offset: ?i32 = null,

    /// The category of the entity. The recognized categories are `GENERIC` or
    /// `BRAND_NAME`.
    category: ?RxNormEntityCategory = null,

    /// The 0-based character offset in the input text that shows where the entity
    /// ends. The
    /// offset returns the UTF-8 code point in the string.
    end_offset: ?i32 = null,

    /// The numeric identifier for the entity. This is a monotonically increasing id
    /// unique within
    /// this response rather than a global unique identifier.
    id: ?i32 = null,

    /// The RxNorm concepts that the entity could refer to, along with a score
    /// indicating the
    /// likelihood of the match.
    rx_norm_concepts: ?[]const RxNormConcept = null,

    /// The level of confidence that Amazon Comprehend Medical has in the accuracy
    /// of the detected
    /// entity.
    score: ?f32 = null,

    /// The segment of input text extracted from which the entity was detected.
    text: ?[]const u8 = null,

    /// Contextual information for the entity.
    traits: ?[]const RxNormTrait = null,

    /// Describes the specific type of entity. For InferRxNorm, the recognized
    /// entity type is
    /// `MEDICATION`.
    @"type": ?RxNormEntityType = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .begin_offset = "BeginOffset",
        .category = "Category",
        .end_offset = "EndOffset",
        .id = "Id",
        .rx_norm_concepts = "RxNormConcepts",
        .score = "Score",
        .text = "Text",
        .traits = "Traits",
        .@"type" = "Type",
    };
};
