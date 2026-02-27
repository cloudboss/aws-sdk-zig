pub const ScanMode = enum {
    progressive,
    interlace,
    progressive_segmented_frame,

    pub const json_field_names = .{
        .progressive = "progressive",
        .interlace = "interlace",
        .progressive_segmented_frame = "progressive_segmented_frame",
    };
};
