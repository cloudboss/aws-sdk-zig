pub const LifecyclePolicyDetailFilterType = enum {
    age,
    count,

    pub const json_field_names = .{
        .age = "AGE",
        .count = "COUNT",
    };
};
