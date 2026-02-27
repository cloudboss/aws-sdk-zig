pub const Visibility = enum {
    all,
    assigned,
    none,

    pub const json_field_names = .{
        .all = "All",
        .assigned = "Assigned",
        .none = "None",
    };
};
