/// Scte35 Segmentation Scope
pub const Scte35SegmentationScope = enum {
    all_output_groups,
    scte35_enabled_output_groups,

    pub const json_field_names = .{
        .all_output_groups = "ALL_OUTPUT_GROUPS",
        .scte35_enabled_output_groups = "SCTE35_ENABLED_OUTPUT_GROUPS",
    };
};
