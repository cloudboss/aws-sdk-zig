const BlockReference = @import("block_reference.zig").BlockReference;
const EntityType = @import("entity_type.zig").EntityType;

/// Provides information about an entity.
pub const Entity = struct {
    /// The zero-based offset from the beginning of the source text to the first
    /// character in the
    /// entity.
    ///
    /// This field is empty for non-text input.
    begin_offset: ?i32 = null,

    /// A reference to each block for this entity. This field is empty for
    /// plain-text input.
    block_references: ?[]const BlockReference = null,

    /// The zero-based offset from the beginning of the source text to the last
    /// character in the
    /// entity.
    ///
    /// This field is empty for non-text input.
    end_offset: ?i32 = null,

    /// The level of confidence that Amazon Comprehend has in the accuracy of the
    /// detection.
    score: ?f32 = null,

    /// The text of the entity.
    text: ?[]const u8 = null,

    /// The entity type. For entity detection using the built-in model, this field
    /// contains one of the
    /// standard entity types listed below.
    ///
    /// For custom entity detection, this field contains one of the
    /// entity types that you specified when you trained your custom model.
    @"type": ?EntityType = null,

    pub const json_field_names = .{
        .begin_offset = "BeginOffset",
        .block_references = "BlockReferences",
        .end_offset = "EndOffset",
        .score = "Score",
        .text = "Text",
        .@"type" = "Type",
    };
};
