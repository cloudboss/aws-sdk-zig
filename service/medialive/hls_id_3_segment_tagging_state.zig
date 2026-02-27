/// State of HLS ID3 Segment Tagging
pub const HlsId3SegmentTaggingState = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
