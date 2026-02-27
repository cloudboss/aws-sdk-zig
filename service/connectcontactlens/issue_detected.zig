const CharacterOffsets = @import("character_offsets.zig").CharacterOffsets;

/// Potential issues that are detected based on an artificial intelligence
/// analysis of
/// each turn in the conversation.
pub const IssueDetected = struct {
    /// The offset for when the issue was detected in the segment.
    character_offsets: CharacterOffsets,

    pub const json_field_names = .{
        .character_offsets = "CharacterOffsets",
    };
};
