const EntityType = @import("entity_type.zig").EntityType;
const RelationshipType = @import("relationship_type.zig").RelationshipType;
const Trait = @import("trait.zig").Trait;
const EntitySubType = @import("entity_sub_type.zig").EntitySubType;

/// An extracted segment of the text that is an attribute of an entity, or
/// otherwise related
/// to an entity, such as the dosage of a medication taken. It contains
/// information about the
/// attribute such as id, begin and end offset within the input text, and the
/// segment of the input
/// text.
pub const Attribute = struct {
    /// The 0-based character offset in the input text that shows where the
    /// attribute begins. The
    /// offset returns the UTF-8 code point in the string.
    begin_offset: ?i32,

    /// The category of attribute.
    category: ?EntityType,

    /// The 0-based character offset in the input text that shows where the
    /// attribute ends. The
    /// offset returns the UTF-8 code point in the string.
    end_offset: ?i32,

    /// The numeric identifier for this attribute. This is a monotonically
    /// increasing id unique
    /// within this response rather than a global unique identifier.
    id: ?i32,

    /// The level of confidence that Amazon Comprehend Medical has that this
    /// attribute is correctly related to this
    /// entity.
    relationship_score: ?f32,

    /// The type of relationship between the entity and attribute. Type for the
    /// relationship is
    /// `OVERLAP`, indicating that the entity occurred at the same time as the
    /// `Date_Expression`.
    relationship_type: ?RelationshipType,

    /// The level of confidence that Amazon Comprehend Medical has that the segment
    /// of text is correctly recognized
    /// as an attribute.
    score: ?f32,

    /// The segment of input text extracted as this attribute.
    text: ?[]const u8,

    /// Contextual information for this attribute.
    traits: ?[]const Trait,

    /// The type of attribute.
    type: ?EntitySubType,

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
        .type = "Type",
    };
};
