pub const ChoiceStatus = enum {
    selected,
    not_applicable,
    unselected,

    pub const json_field_names = .{
        .selected = "SELECTED",
        .not_applicable = "NOT_APPLICABLE",
        .unselected = "UNSELECTED",
    };
};
