pub const PlacementConstraintType = enum {
    distinct_instance,
    member_of,

    pub const json_field_names = .{
        .distinct_instance = "DISTINCT_INSTANCE",
        .member_of = "MEMBER_OF",
    };
};
