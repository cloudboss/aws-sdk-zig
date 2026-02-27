/// M2ts Segmentation Style
pub const M2tsSegmentationStyle = enum {
    maintain_cadence,
    reset_cadence,

    pub const json_field_names = .{
        .maintain_cadence = "MAINTAIN_CADENCE",
        .reset_cadence = "RESET_CADENCE",
    };
};
