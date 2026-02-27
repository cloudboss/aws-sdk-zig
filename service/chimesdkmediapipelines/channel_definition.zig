const ParticipantRole = @import("participant_role.zig").ParticipantRole;

/// Defines an audio channel in a Kinesis video stream.
pub const ChannelDefinition = struct {
    /// The channel ID.
    channel_id: i32 = 0,

    /// Specifies whether the audio in a channel belongs to the `AGENT` or
    /// `CUSTOMER`.
    participant_role: ?ParticipantRole,

    pub const json_field_names = .{
        .channel_id = "ChannelId",
        .participant_role = "ParticipantRole",
    };
};
