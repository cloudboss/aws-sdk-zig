pub const VisualHighlightTrigger = enum {
    data_point_click,
    data_point_hover,
    none,

    pub const json_field_names = .{
        .data_point_click = "DATA_POINT_CLICK",
        .data_point_hover = "DATA_POINT_HOVER",
        .none = "NONE",
    };
};
