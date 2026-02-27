pub const ProvisionedProductPlanType = enum {
    cloudformation,

    pub const json_field_names = .{
        .cloudformation = "CLOUDFORMATION",
    };
};
