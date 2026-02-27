pub const SheetControlSliderType = enum {
    single_point,
    range,

    pub const json_field_names = .{
        .single_point = "SINGLE_POINT",
        .range = "RANGE",
    };
};
