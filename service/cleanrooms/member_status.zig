pub const MemberStatus = enum {
    invited,
    active,
    left,
    removed,

    pub const json_field_names = .{
        .invited = "INVITED",
        .active = "ACTIVE",
        .left = "LEFT",
        .removed = "REMOVED",
    };
};
