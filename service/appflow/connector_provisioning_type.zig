/// The type of provisioning that the connector supports, such as Lambda.
pub const ConnectorProvisioningType = enum {
    lambda,

    pub const json_field_names = .{
        .lambda = "LAMBDA",
    };
};
