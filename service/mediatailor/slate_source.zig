/// Slate VOD source configuration.
pub const SlateSource = struct {
    /// The name of the source location where the slate VOD source is stored.
    source_location_name: ?[]const u8,

    /// The slate VOD source name. The VOD source must already exist in a source
    /// location before it can be used for slate.
    vod_source_name: ?[]const u8,

    pub const json_field_names = .{
        .source_location_name = "SourceLocationName",
        .vod_source_name = "VodSourceName",
    };
};
