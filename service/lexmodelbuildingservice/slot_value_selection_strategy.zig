pub const SlotValueSelectionStrategy = enum {
    original_value,
    top_resolution,

    pub const json_field_names = .{
        .original_value = "ORIGINAL_VALUE",
        .top_resolution = "TOP_RESOLUTION",
    };
};
