pub const DashboardUIState = enum {
    expanded,
    collapsed,

    pub const json_field_names = .{
        .expanded = "EXPANDED",
        .collapsed = "COLLAPSED",
    };
};
