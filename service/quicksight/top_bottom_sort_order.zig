pub const TopBottomSortOrder = enum {
    percent_difference,
    absolute_difference,

    pub const json_field_names = .{
        .percent_difference = "PERCENT_DIFFERENCE",
        .absolute_difference = "ABSOLUTE_DIFFERENCE",
    };
};
