pub const MembershipStatus = enum {
    active,
    removed,
    collaboration_deleted,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .removed = "REMOVED",
        .collaboration_deleted = "COLLABORATION_DELETED",
    };
};
