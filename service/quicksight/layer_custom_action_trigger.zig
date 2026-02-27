pub const LayerCustomActionTrigger = enum {
    data_point_click,
    data_point_menu,

    pub const json_field_names = .{
        .data_point_click = "DATA_POINT_CLICK",
        .data_point_menu = "DATA_POINT_MENU",
    };
};
