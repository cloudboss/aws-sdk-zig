pub const ProductType = enum {
    cloud_formation_template,
    marketplace,
    terraform_open_source,
    terraform_cloud,
    external,

    pub const json_field_names = .{
        .cloud_formation_template = "CLOUD_FORMATION_TEMPLATE",
        .marketplace = "MARKETPLACE",
        .terraform_open_source = "TERRAFORM_OPEN_SOURCE",
        .terraform_cloud = "TERRAFORM_CLOUD",
        .external = "EXTERNAL",
    };
};
