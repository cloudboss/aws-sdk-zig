pub const LayoutElementType = enum {
    visual,
    filter_control,
    parameter_control,
    text_box,
    image,

    pub const json_field_names = .{
        .visual = "VISUAL",
        .filter_control = "FILTER_CONTROL",
        .parameter_control = "PARAMETER_CONTROL",
        .text_box = "TEXT_BOX",
        .image = "IMAGE",
    };
};
