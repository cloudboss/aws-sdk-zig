pub const UserProfileStatus = enum {
    assigned,
    not_assigned,
    activated,
    deactivated,

    pub const json_field_names = .{
        .assigned = "ASSIGNED",
        .not_assigned = "NOT_ASSIGNED",
        .activated = "ACTIVATED",
        .deactivated = "DEACTIVATED",
    };
};
