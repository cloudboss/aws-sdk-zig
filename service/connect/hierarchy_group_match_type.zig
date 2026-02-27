pub const HierarchyGroupMatchType = enum {
    exact,
    with_child_groups,

    pub const json_field_names = .{
        .exact = "EXACT",
        .with_child_groups = "WITH_CHILD_GROUPS",
    };
};
