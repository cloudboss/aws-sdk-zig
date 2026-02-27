pub const AdditionalResourceType = enum {
    helpful_resource,
    improvement_plan,

    pub const json_field_names = .{
        .helpful_resource = "HELPFUL_RESOURCE",
        .improvement_plan = "IMPROVEMENT_PLAN",
    };
};
