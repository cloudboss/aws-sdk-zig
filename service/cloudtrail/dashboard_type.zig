pub const DashboardType = enum {
    managed,
    custom,

    pub const json_field_names = .{
        .managed = "MANAGED",
        .custom = "CUSTOM",
    };
};
