pub const MembershipLevel = enum {
    viewer,
    contributor,
    owner,
    manager,

    pub const json_field_names = .{
        .viewer = "VIEWER",
        .contributor = "CONTRIBUTOR",
        .owner = "OWNER",
        .manager = "MANAGER",
    };
};
