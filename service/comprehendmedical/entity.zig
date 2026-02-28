const Attribute = @import("attribute.zig").Attribute;
const EntityType = @import("entity_type.zig").EntityType;
const Trait = @import("trait.zig").Trait;
const EntitySubType = @import("entity_sub_type.zig").EntitySubType;

/// Provides information about an extracted medical entity.
pub const Entity = struct {
    /// The extracted attributes that relate to this entity.
    attributes: ?[]const Attribute,

    /// The 0-based character offset in the input text that shows where the entity
    /// begins. The
    /// offset returns the UTF-8 code point in the string.
    begin_offset: ?i32,

    /// The category of the entity.
    category: ?EntityType,

    /// The 0-based character offset in the input text that shows where the entity
    /// ends. The
    /// offset returns the UTF-8 code point in the string.
    end_offset: ?i32,

    /// The numeric identifier for the entity. This is a monotonically increasing id
    /// unique
    /// within this response rather than a global unique identifier.
    id: ?i32,

    /// The level of confidence that Amazon Comprehend Medical has in the accuracy
    /// of the detection.
    score: ?f32,

    /// The segment of input text extracted as this entity.
    text: ?[]const u8,

    /// Contextual information for the entity.
    traits: ?[]const Trait,

    /// Describes the specific type of entity with category of entities.
    @"type": ?EntitySubType,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .begin_offset = "BeginOffset",
        .category = "Category",
        .end_offset = "EndOffset",
        .id = "Id",
        .score = "Score",
        .text = "Text",
        .traits = "Traits",
        .@"type" = "Type",
    };
};
