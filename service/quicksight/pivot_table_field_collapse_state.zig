pub const PivotTableFieldCollapseState = enum {
    collapsed,
    expanded,

    pub const json_field_names = .{
        .collapsed = "COLLAPSED",
        .expanded = "EXPANDED",
    };
};
