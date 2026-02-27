pub const QualificationTypeStatus = enum {
    active,
    inactive,

    pub const json_field_names = .{
        .active = "Active",
        .inactive = "Inactive",
    };
};
