/// Smooth Group Sparse Track Type
pub const SmoothGroupSparseTrackType = enum {
    none,
    scte_35,
    scte_35_without_segmentation,

    pub const json_field_names = .{
        .none = "NONE",
        .scte_35 = "SCTE_35",
        .scte_35_without_segmentation = "SCTE_35_WITHOUT_SEGMENTATION",
    };
};
