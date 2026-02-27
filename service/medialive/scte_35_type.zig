/// Scte35 Type
pub const Scte35Type = enum {
    none,
    scte_35_without_segmentation,

    pub const json_field_names = .{
        .none = "NONE",
        .scte_35_without_segmentation = "SCTE_35_WITHOUT_SEGMENTATION",
    };
};
