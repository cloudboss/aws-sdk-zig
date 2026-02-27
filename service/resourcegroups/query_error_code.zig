pub const QueryErrorCode = enum {
    cloudformation_stack_inactive,
    cloudformation_stack_not_existing,
    cloudformation_stack_unassumable_role,
    resource_type_not_supported,

    pub const json_field_names = .{
        .cloudformation_stack_inactive = "CLOUDFORMATION_STACK_INACTIVE",
        .cloudformation_stack_not_existing = "CLOUDFORMATION_STACK_NOT_EXISTING",
        .cloudformation_stack_unassumable_role = "CLOUDFORMATION_STACK_UNASSUMABLE_ROLE",
        .resource_type_not_supported = "RESOURCE_TYPE_NOT_SUPPORTED",
    };
};
