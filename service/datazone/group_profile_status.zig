pub const GroupProfileStatus = enum {
    assigned,
    not_assigned,

    pub const json_field_names = .{
        .assigned = "ASSIGNED",
        .not_assigned = "NOT_ASSIGNED",
    };
};
