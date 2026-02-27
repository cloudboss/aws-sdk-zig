pub const ProvisioningArtifactType = enum {
    cloud_formation_template,
    marketplace_ami,
    marketplace_car,
    terraform_open_source,
    terraform_cloud,
    external,

    pub const json_field_names = .{
        .cloud_formation_template = "CLOUD_FORMATION_TEMPLATE",
        .marketplace_ami = "MARKETPLACE_AMI",
        .marketplace_car = "MARKETPLACE_CAR",
        .terraform_open_source = "TERRAFORM_OPEN_SOURCE",
        .terraform_cloud = "TERRAFORM_CLOUD",
        .external = "EXTERNAL",
    };
};
