const HlsAutoSelect = @import("hls_auto_select.zig").HlsAutoSelect;
const HlsDefault = @import("hls_default.zig").HlsDefault;

/// Media Package V2 Destination Settings
pub const MediaPackageV2DestinationSettings = struct {
    /// Applies only to an output that contains audio. If you want to put several
    /// audio encodes into one audio rendition group, decide on a name (ID) for the
    /// group. Then in every audio output that you want to belong to that group,
    /// enter that ID in this field. Note that this information is part of the HLS
    /// specification (not the CMAF specification), but if you include it then
    /// MediaPackage will include it in the manifest it creates for the video
    /// player.
    audio_group_id: ?[]const u8 = null,

    /// Applies only to an output that contains video, and only if you want to
    /// associate one or more audio groups to this video. In this field you assign
    /// the groups that you create (in the Group ID fields in the various audio
    /// outputs). Enter one group ID, or enter a comma-separated list of group IDs.
    /// Note that this information is part of the HLS specification (not the CMAF
    /// specification), but if you include it then MediaPackage will include it in
    /// the manifest it creates for the video player.
    audio_rendition_sets: ?[]const u8 = null,

    /// Specifies whether MediaPackage should set this output as the auto-select
    /// rendition in the HLS manifest. YES means this must be the auto-select. NO
    /// means this should never be the auto-select. OMIT means MediaPackage decides
    /// what to set on this rendition.
    /// When you consider all the renditions, follow these guidelines. You can set
    /// zero or one renditions to YES. You can set zero or more renditions to NO,
    /// but you can't set all renditions to NO. You can set zero, some, or all to
    /// OMIT.
    hls_auto_select: ?HlsAutoSelect = null,

    /// Specifies whether MediaPackage should set this output as the default
    /// rendition in the HLS manifest. YES means this must be the default. NO means
    /// this should never be the default. OMIT means MediaPackage decides what to
    /// set on this rendition.
    /// When you consider all the renditions, follow these guidelines. You can set
    /// zero or one renditions to YES. You can set zero or more renditions to NO,
    /// but you can't set all renditions to NO. You can set zero, some, or all to
    /// OMIT.
    hls_default: ?HlsDefault = null,

    pub const json_field_names = .{
        .audio_group_id = "AudioGroupId",
        .audio_rendition_sets = "AudioRenditionSets",
        .hls_auto_select = "HlsAutoSelect",
        .hls_default = "HlsDefault",
    };
};
