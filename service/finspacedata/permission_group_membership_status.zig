pub const PermissionGroupMembershipStatus = enum {
    addition_in_progress,
    addition_success,
    removal_in_progress,

    pub const json_field_names = .{
        .addition_in_progress = "ADDITION_IN_PROGRESS",
        .addition_success = "ADDITION_SUCCESS",
        .removal_in_progress = "REMOVAL_IN_PROGRESS",
    };
};
