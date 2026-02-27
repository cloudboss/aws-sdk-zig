pub const SelectionStatus = enum {
    selected,
    not_selected,

    pub const json_field_names = .{
        .selected = "SELECTED",
        .not_selected = "NOT_SELECTED",
    };
};
