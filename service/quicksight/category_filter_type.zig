pub const CategoryFilterType = enum {
    custom_filter,
    custom_filter_list,
    filter_list,

    pub const json_field_names = .{
        .custom_filter = "CUSTOM_FILTER",
        .custom_filter_list = "CUSTOM_FILTER_LIST",
        .filter_list = "FILTER_LIST",
    };
};
