pub const SheetControlDateTimePickerType = enum {
    single_valued,
    date_range,

    pub const json_field_names = .{
        .single_valued = "SINGLE_VALUED",
        .date_range = "DATE_RANGE",
    };
};
