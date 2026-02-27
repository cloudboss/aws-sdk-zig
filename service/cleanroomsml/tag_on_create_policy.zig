pub const TagOnCreatePolicy = enum {
    from_parent_resource,
    none,

    pub const json_field_names = .{
        .from_parent_resource = "FROM_PARENT_RESOURCE",
        .none = "NONE",
    };
};
