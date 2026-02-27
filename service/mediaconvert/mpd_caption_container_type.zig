/// Use this setting only in DASH output groups that include sidecar TTML, IMSC
/// or WEBVTT captions. You specify sidecar captions in a separate output from
/// your audio and video. Choose Raw for captions in a single XML file in a raw
/// container. Choose Fragmented MPEG-4 for captions in XML format contained
/// within fragmented MP4 files. This set of fragmented MP4 files is separate
/// from your video and audio fragmented MP4 files.
pub const MpdCaptionContainerType = enum {
    raw,
    fragmented_mp4,

    pub const json_field_names = .{
        .raw = "RAW",
        .fragmented_mp4 = "FRAGMENTED_MP4",
    };
};
