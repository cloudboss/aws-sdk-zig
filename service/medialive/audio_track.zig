/// Audio Track
pub const AudioTrack = struct {
    /// 1-based integer value that maps to a specific audio track
    track: i32,

    pub const json_field_names = .{
        .track = "Track",
    };
};
