pub const TileOrder = enum {
    join_sequence,
    speaker_sequence,

    pub const json_field_names = .{
        .join_sequence = "JoinSequence",
        .speaker_sequence = "SpeakerSequence",
    };
};
