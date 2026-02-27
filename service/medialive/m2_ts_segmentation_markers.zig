/// M2ts Segmentation Markers
pub const M2tsSegmentationMarkers = enum {
    ebp,
    ebp_legacy,
    none,
    psi_segstart,
    rai_adapt,
    rai_segstart,

    pub const json_field_names = .{
        .ebp = "EBP",
        .ebp_legacy = "EBP_LEGACY",
        .none = "NONE",
        .psi_segstart = "PSI_SEGSTART",
        .rai_adapt = "RAI_ADAPT",
        .rai_segstart = "RAI_SEGSTART",
    };
};
