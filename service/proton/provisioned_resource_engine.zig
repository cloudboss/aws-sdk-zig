/// List of provisioning engines
pub const ProvisionedResourceEngine = enum {
    cloudformation,
    terraform,

    pub const json_field_names = .{
        .cloudformation = "CLOUDFORMATION",
        .terraform = "TERRAFORM",
    };
};
