const ActiveSpeakerPosition = @import("active_speaker_position.zig").ActiveSpeakerPosition;

/// Defines the configuration for an `ActiveSpeakerOnly` video tile.
pub const ActiveSpeakerOnlyConfiguration = struct {
    /// The position of the `ActiveSpeakerOnly` video tile.
    active_speaker_position: ?ActiveSpeakerPosition,

    pub const json_field_names = .{
        .active_speaker_position = "ActiveSpeakerPosition",
    };
};
