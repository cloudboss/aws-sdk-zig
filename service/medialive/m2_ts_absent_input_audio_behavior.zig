/// M2ts Absent Input Audio Behavior
pub const M2tsAbsentInputAudioBehavior = enum {
    drop,
    encode_silence,

    pub const json_field_names = .{
        .drop = "DROP",
        .encode_silence = "ENCODE_SILENCE",
    };
};
