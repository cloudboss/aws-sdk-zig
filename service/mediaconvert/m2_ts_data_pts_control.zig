/// If you select ALIGN_TO_VIDEO, MediaConvert writes captions and data packets
/// with Presentation Timestamp (PTS) values greater than or equal to the first
/// video packet PTS (MediaConvert drops captions and data packets with lesser
/// PTS values). Keep the default value to allow all PTS values.
pub const M2tsDataPtsControl = enum {
    auto,
    align_to_video,

    pub const json_field_names = .{
        .auto = "AUTO",
        .align_to_video = "ALIGN_TO_VIDEO",
    };
};
