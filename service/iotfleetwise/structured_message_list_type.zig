pub const StructuredMessageListType = enum {
    fixed_capacity,
    dynamic_unbounded_capacity,
    dynamic_bounded_capacity,

    pub const json_field_names = .{
        .fixed_capacity = "FIXED_CAPACITY",
        .dynamic_unbounded_capacity = "DYNAMIC_UNBOUNDED_CAPACITY",
        .dynamic_bounded_capacity = "DYNAMIC_BOUNDED_CAPACITY",
    };
};
