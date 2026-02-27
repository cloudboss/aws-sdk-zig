pub const QueryType = enum {
    tag_filters_1_0,
    cloudformation_stack_1_0,

    pub const json_field_names = .{
        .tag_filters_1_0 = "TAG_FILTERS_1_0",
        .cloudformation_stack_1_0 = "CLOUDFORMATION_STACK_1_0",
    };
};
