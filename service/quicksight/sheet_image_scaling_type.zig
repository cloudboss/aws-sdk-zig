pub const SheetImageScalingType = enum {
    scale_to_width,
    scale_to_height,
    scale_to_container,
    scale_none,

    pub const json_field_names = .{
        .scale_to_width = "SCALE_TO_WIDTH",
        .scale_to_height = "SCALE_TO_HEIGHT",
        .scale_to_container = "SCALE_TO_CONTAINER",
        .scale_none = "SCALE_NONE",
    };
};
