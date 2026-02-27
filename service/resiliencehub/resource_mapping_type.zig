pub const ResourceMappingType = enum {
    cfn_stack,
    resource,
    app_registry_app,
    resource_group,
    terraform,
    eks,

    pub const json_field_names = .{
        .cfn_stack = "CFN_STACK",
        .resource = "RESOURCE",
        .app_registry_app = "APP_REGISTRY_APP",
        .resource_group = "RESOURCE_GROUP",
        .terraform = "TERRAFORM",
        .eks = "EKS",
    };
};
