const ICD10CMEntityType = @import("icd10_cm_entity_type.zig").ICD10CMEntityType;
const ICD10CMRelationshipType = @import("icd10_cm_relationship_type.zig").ICD10CMRelationshipType;
const ICD10CMTrait = @import("icd10_cm_trait.zig").ICD10CMTrait;
const ICD10CMAttributeType = @import("icd10_cm_attribute_type.zig").ICD10CMAttributeType;

/// The detected attributes that relate to an entity. This includes an extracted
/// segment of
/// the text that is an attribute of an entity, or otherwise related to an
/// entity. InferICD10CM
/// detects the following attributes: `Direction`, `System, Organ or Site`,
/// and `Acuity`.
pub const ICD10CMAttribute = struct {
    /// The 0-based character offset in the input text that shows where the
    /// attribute begins. The
    /// offset returns the UTF-8 code point in the string.
    begin_offset: ?i32,

    /// The category of attribute. Can be either of `DX_NAME` or `TIME_EXPRESSION`.
    category: ?ICD10CMEntityType,

    /// The 0-based character offset in the input text that shows where the
    /// attribute ends. The
    /// offset returns the UTF-8 code point in the string.
    end_offset: ?i32,

    /// The numeric identifier for this attribute. This is a monotonically
    /// increasing id unique
    /// within this response rather than a global unique identifier.
    id: ?i32,

    /// The level of confidence that Amazon Comprehend Medical has that this
    /// attribute is
    /// correctly related to this entity.
    relationship_score: ?f32,

    /// The type of relationship between the entity and attribute. Type for the
    /// relationship can
    /// be either of `OVERLAP` or `SYSTEM_ORGAN_SITE`.
    relationship_type: ?ICD10CMRelationshipType,

    /// The level of confidence that Amazon Comprehend Medical has that the segment
    /// of text is
    /// correctly recognized as an attribute.
    score: ?f32,

    /// The segment of input text which contains the detected attribute.
    text: ?[]const u8,

    /// The contextual information for the attribute. The traits recognized by
    /// InferICD10CM are
    /// `DIAGNOSIS`, `SIGN`, `SYMPTOM`, and
    /// `NEGATION`.
    traits: ?[]const ICD10CMTrait,

    /// The type of attribute. InferICD10CM detects entities of the type `DX_NAME`.
    @"type": ?ICD10CMAttributeType,

    pub const json_field_names = .{
        .begin_offset = "BeginOffset",
        .category = "Category",
        .end_offset = "EndOffset",
        .id = "Id",
        .relationship_score = "RelationshipScore",
        .relationship_type = "RelationshipType",
        .score = "Score",
        .text = "Text",
        .traits = "Traits",
        .@"type" = "Type",
    };
};
