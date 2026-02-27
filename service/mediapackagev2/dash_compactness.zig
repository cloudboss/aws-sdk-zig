pub const DashCompactness = enum {
    standard,
    none,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .none = "NONE",
    };
};
