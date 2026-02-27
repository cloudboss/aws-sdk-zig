/// Audio Hls Rendition Selection
pub const AudioHlsRenditionSelection = struct {
    /// Specifies the GROUP-ID in the #EXT-X-MEDIA tag of the target HLS audio
    /// rendition.
    group_id: []const u8,

    /// Specifies the NAME in the #EXT-X-MEDIA tag of the target HLS audio
    /// rendition.
    name: []const u8,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .name = "Name",
    };
};
