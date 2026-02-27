/// Hls Iv Source
pub const HlsIvSource = enum {
    explicit,
    follows_segment_number,

    pub const json_field_names = .{
        .explicit = "EXPLICIT",
        .follows_segment_number = "FOLLOWS_SEGMENT_NUMBER",
    };
};
