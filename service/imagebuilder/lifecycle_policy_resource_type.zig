pub const LifecyclePolicyResourceType = enum {
    ami_image,
    container_image,

    pub const json_field_names = .{
        .ami_image = "AMI_IMAGE",
        .container_image = "CONTAINER_IMAGE",
    };
};
