pub const ResourceType = enum {
    cfn_stack,
    resource_tag_value,

    pub const json_field_names = .{
        .cfn_stack = "CFN_STACK",
        .resource_tag_value = "RESOURCE_TAG_VALUE",
    };
};
