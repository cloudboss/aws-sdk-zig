/// Settings for the action to insert ID3 metadata (as a one-time action) in HLS
/// output groups.
pub const HlsTimedMetadataScheduleActionSettings = struct {
    /// Enter a base64 string that contains one or more fully formed ID3 tags.See
    /// the ID3 specification: http://id3.org/id3v2.4.0-structure
    id_3: []const u8,

    pub const json_field_names = .{
        .id_3 = "Id3",
    };
};
