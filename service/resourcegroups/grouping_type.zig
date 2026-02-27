pub const GroupingType = enum {
    group,
    ungroup,

    pub const json_field_names = .{
        .group = "GROUP",
        .ungroup = "UNGROUP",
    };
};
