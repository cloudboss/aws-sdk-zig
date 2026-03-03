const SNOMEDCTEntityCategory = @import("snomedct_entity_category.zig").SNOMEDCTEntityCategory;
const SNOMEDCTRelationshipType = @import("snomedct_relationship_type.zig").SNOMEDCTRelationshipType;
const SNOMEDCTConcept = @import("snomedct_concept.zig").SNOMEDCTConcept;
const SNOMEDCTTrait = @import("snomedct_trait.zig").SNOMEDCTTrait;
const SNOMEDCTAttributeType = @import("snomedct_attribute_type.zig").SNOMEDCTAttributeType;

/// The extracted attributes that relate to an entity. An extracted segment of
/// the text that is an attribute of an entity, or otherwise related to an
/// entity, such as the dosage of a medication taken.
pub const SNOMEDCTAttribute = struct {
    /// The 0-based character offset in the input text that shows where the
    /// attribute begins. The offset returns the UTF-8 code point in the string.
    begin_offset: ?i32 = null,

    /// The category of the detected attribute. Possible categories include
    /// MEDICAL_CONDITION, ANATOMY, and TEST_TREATMENT_PROCEDURE.
    category: ?SNOMEDCTEntityCategory = null,

    /// The 0-based character offset in the input text that shows where the
    /// attribute ends. The offset returns the UTF-8 code point in the string.
    end_offset: ?i32 = null,

    /// The numeric identifier for this attribute. This is a monotonically
    /// increasing id unique within this response rather than a global unique
    /// identifier.
    id: ?i32 = null,

    /// The level of confidence that Amazon Comprehend Medical has that this
    /// attribute is correctly related to this entity.
    relationship_score: ?f32 = null,

    /// The type of relationship that exists between the entity and the related
    /// attribute.
    relationship_type: ?SNOMEDCTRelationshipType = null,

    /// The level of confidence that Amazon Comprehend Medical has that the segment
    /// of text is correctly recognized as an attribute.
    score: ?f32 = null,

    /// The SNOMED-CT concepts specific to an attribute, along with a score
    /// indicating the likelihood of the match.
    snomedct_concepts: ?[]const SNOMEDCTConcept = null,

    /// The segment of input text extracted as this attribute.
    text: ?[]const u8 = null,

    /// Contextual information for an attribute. Examples include signs, symptoms,
    /// diagnosis, and negation.
    traits: ?[]const SNOMEDCTTrait = null,

    /// The type of attribute. Possible types include DX_NAME, ACUITY, DIRECTION,
    /// SYSTEM_ORGAN_SITE,TEST_NAME, TEST_VALUE, TEST_UNIT, PROCEDURE_NAME, and
    /// TREATMENT_NAME.
    @"type": ?SNOMEDCTAttributeType = null,

    pub const json_field_names = .{
        .begin_offset = "BeginOffset",
        .category = "Category",
        .end_offset = "EndOffset",
        .id = "Id",
        .relationship_score = "RelationshipScore",
        .relationship_type = "RelationshipType",
        .score = "Score",
        .snomedct_concepts = "SNOMEDCTConcepts",
        .text = "Text",
        .traits = "Traits",
        .@"type" = "Type",
    };
};
