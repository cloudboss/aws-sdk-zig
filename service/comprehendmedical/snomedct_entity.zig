const SNOMEDCTAttribute = @import("snomedct_attribute.zig").SNOMEDCTAttribute;
const SNOMEDCTEntityCategory = @import("snomedct_entity_category.zig").SNOMEDCTEntityCategory;
const SNOMEDCTConcept = @import("snomedct_concept.zig").SNOMEDCTConcept;
const SNOMEDCTTrait = @import("snomedct_trait.zig").SNOMEDCTTrait;
const SNOMEDCTEntityType = @import("snomedct_entity_type.zig").SNOMEDCTEntityType;

/// The collection of medical entities extracted from the input text and their
/// associated information. For each entity, the response provides the entity
/// text, the entity category, where the entity text begins and ends, and the
/// level of confidence that Amazon Comprehend Medical has in the detection and
/// analysis. Attributes and traits of the entity are also returned.
pub const SNOMEDCTEntity = struct {
    /// An extracted segment of the text that is an attribute of an entity, or
    /// otherwise related to an entity, such as the dosage of a medication taken.
    attributes: ?[]const SNOMEDCTAttribute,

    /// The 0-based character offset in the input text that shows where the entity
    /// begins. The offset returns the UTF-8 code point in the string.
    begin_offset: ?i32,

    /// The category of the detected entity. Possible categories are
    /// MEDICAL_CONDITION, ANATOMY, or TEST_TREATMENT_PROCEDURE.
    category: ?SNOMEDCTEntityCategory,

    /// The 0-based character offset in the input text that shows where the entity
    /// ends. The offset returns the UTF-8 code point in the string.
    end_offset: ?i32,

    /// The numeric identifier for the entity. This is a monotonically increasing id
    /// unique within this response rather than a global unique identifier.
    id: ?i32,

    /// The level of confidence that Amazon Comprehend Medical has in the accuracy
    /// of the detected entity.
    score: ?f32,

    /// The SNOMED concepts that the entity could refer to, along with a score
    /// indicating the likelihood of the match.
    snomedct_concepts: ?[]const SNOMEDCTConcept,

    /// The segment of input text extracted as this entity.
    text: ?[]const u8,

    /// Contextual information for the entity.
    traits: ?[]const SNOMEDCTTrait,

    /// Describes the specific type of entity with category of entities. Possible
    /// types include DX_NAME, ACUITY, DIRECTION, SYSTEM_ORGAN_SITE, TEST_NAME,
    /// TEST_VALUE, TEST_UNIT, PROCEDURE_NAME, or TREATMENT_NAME.
    @"type": ?SNOMEDCTEntityType,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .begin_offset = "BeginOffset",
        .category = "Category",
        .end_offset = "EndOffset",
        .id = "Id",
        .score = "Score",
        .snomedct_concepts = "SNOMEDCTConcepts",
        .text = "Text",
        .traits = "Traits",
        .@"type" = "Type",
    };
};
