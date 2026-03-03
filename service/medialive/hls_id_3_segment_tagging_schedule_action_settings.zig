/// Settings for the action to insert ID3 metadata in every segment, in HLS
/// output groups.
pub const HlsId3SegmentTaggingScheduleActionSettings = struct {
    /// Complete this parameter if you want to specify the entire ID3 metadata.
    /// Enter a base64 string that contains one or more fully formed ID3 tags,
    /// according to the ID3 specification: http://id3.org/id3v2.4.0-structure
    id_3: ?[]const u8 = null,

    /// Complete this parameter if you want to specify only the metadata, not the
    /// entire frame. MediaLive will insert the metadata in a TXXX frame. Enter the
    /// value as plain text. You can include standard MediaLive variable data such
    /// as the current segment number.
    tag: ?[]const u8 = null,

    pub const json_field_names = .{
        .id_3 = "Id3",
        .tag = "Tag",
    };
};
