pub const TableCellImageScalingConfiguration = enum {
    fit_to_cell_height,
    fit_to_cell_width,
    do_not_scale,

    pub const json_field_names = .{
        .fit_to_cell_height = "FIT_TO_CELL_HEIGHT",
        .fit_to_cell_width = "FIT_TO_CELL_WIDTH",
        .do_not_scale = "DO_NOT_SCALE",
    };
};
