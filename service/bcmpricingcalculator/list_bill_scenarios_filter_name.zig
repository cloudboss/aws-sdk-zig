pub const ListBillScenariosFilterName = enum {
    status,
    name,
    group_sharing_preference,
    cost_category_arn,

    pub const json_field_names = .{
        .status = "STATUS",
        .name = "NAME",
        .group_sharing_preference = "GROUP_SHARING_PREFERENCE",
        .cost_category_arn = "COST_CATEGORY_ARN",
    };
};
