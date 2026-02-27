pub const RecommendationTarget = enum {
    same_instance_family,
    cross_instance_family,

    pub const json_field_names = .{
        .same_instance_family = "SAME_INSTANCE_FAMILY",
        .cross_instance_family = "CROSS_INSTANCE_FAMILY",
    };
};
