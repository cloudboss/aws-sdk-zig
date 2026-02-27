const CharacterOffsets = @import("character_offsets.zig").CharacterOffsets;

/// Lists the issues that were identified in your audio segment.
pub const IssueDetected = struct {
    /// Provides the timestamps that identify when in an audio segment the specified
    /// issue occurs.
    character_offsets: ?CharacterOffsets,

    pub const json_field_names = .{
        .character_offsets = "CharacterOffsets",
    };
};
