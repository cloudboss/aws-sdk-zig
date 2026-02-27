pub const CustomContentImageScalingConfiguration = enum {
    fit_to_height,
    fit_to_width,
    do_not_scale,
    scale_to_visual,

    pub const json_field_names = .{
        .fit_to_height = "FIT_TO_HEIGHT",
        .fit_to_width = "FIT_TO_WIDTH",
        .do_not_scale = "DO_NOT_SCALE",
        .scale_to_visual = "SCALE_TO_VISUAL",
    };
};
