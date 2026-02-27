pub const SheetControlListType = enum {
    multi_select,
    single_select,

    pub const json_field_names = .{
        .multi_select = "MULTI_SELECT",
        .single_select = "SINGLE_SELECT",
    };
};
