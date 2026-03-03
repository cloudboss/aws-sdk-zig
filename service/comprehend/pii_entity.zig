const PiiEntityType = @import("pii_entity_type.zig").PiiEntityType;

/// Provides information about a PII entity.
pub const PiiEntity = struct {
    /// The zero-based offset from the beginning of the source text to the first
    /// character in the
    /// entity.
    begin_offset: ?i32 = null,

    /// The zero-based offset from the beginning of the source text to the last
    /// character in the
    /// entity.
    end_offset: ?i32 = null,

    /// The level of confidence that Amazon Comprehend has in the accuracy of the
    /// detection.
    score: ?f32 = null,

    /// The entity's type.
    @"type": ?PiiEntityType = null,

    pub const json_field_names = .{
        .begin_offset = "BeginOffset",
        .end_offset = "EndOffset",
        .score = "Score",
        .@"type" = "Type",
    };
};
