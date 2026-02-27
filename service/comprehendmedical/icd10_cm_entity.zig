const ICD10CMAttribute = @import("icd10_cm_attribute.zig").ICD10CMAttribute;
const ICD10CMEntityCategory = @import("icd10_cm_entity_category.zig").ICD10CMEntityCategory;
const ICD10CMConcept = @import("icd10_cm_concept.zig").ICD10CMConcept;
const ICD10CMTrait = @import("icd10_cm_trait.zig").ICD10CMTrait;
const ICD10CMEntityType = @import("icd10_cm_entity_type.zig").ICD10CMEntityType;

/// The collection of medical entities extracted from the input text and their
/// associated
/// information. For each entity, the response provides the entity text, the
/// entity category,
/// where the entity text begins and ends, and the level of confidence that
/// Amazon Comprehend
/// Medical has in the detection and analysis. Attributes and traits of the
/// entity are also
/// returned.
pub const ICD10CMEntity = struct {
    /// The detected attributes that relate to the entity. An extracted segment of
    /// the text that
    /// is an attribute of an entity, or otherwise related to an entity, such as the
    /// nature of a
    /// medical condition.
    attributes: ?[]const ICD10CMAttribute,

    /// The 0-based character offset in the input text that shows where the entity
    /// begins. The
    /// offset returns the UTF-8 code point in the string.
    begin_offset: ?i32,

    /// The category of the entity. InferICD10CM detects entities in the
    /// `MEDICAL_CONDITION` category.
    category: ?ICD10CMEntityCategory,

    /// The 0-based character offset in the input text that shows where the entity
    /// ends. The
    /// offset returns the UTF-8 code point in the string.
    end_offset: ?i32,

    /// The ICD-10-CM concepts that the entity could refer to, along with a score
    /// indicating the
    /// likelihood of the match.
    icd10_cm_concepts: ?[]const ICD10CMConcept,

    /// The numeric identifier for the entity. This is a monotonically increasing id
    /// unique within
    /// this response rather than a global unique identifier.
    id: ?i32,

    /// The level of confidence that Amazon Comprehend Medical has in the accuracy
    /// of the
    /// detection.
    score: ?f32,

    /// The segment of input text that is matched to the detected entity.
    text: ?[]const u8,

    /// Provides Contextual information for the entity. The traits recognized by
    /// InferICD10CM are
    /// `DIAGNOSIS`, `SIGN`, `SYMPTOM`, and
    /// `NEGATION.`
    traits: ?[]const ICD10CMTrait,

    /// Describes the specific type of entity with category of entities.
    /// InferICD10CM detects
    /// entities of the type `DX_NAME` and `TIME_EXPRESSION`.
    type: ?ICD10CMEntityType,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .begin_offset = "BeginOffset",
        .category = "Category",
        .end_offset = "EndOffset",
        .icd10_cm_concepts = "ICD10CMConcepts",
        .id = "Id",
        .score = "Score",
        .text = "Text",
        .traits = "Traits",
        .type = "Type",
    };
};
