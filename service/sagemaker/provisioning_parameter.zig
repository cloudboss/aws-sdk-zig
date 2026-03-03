/// A key value pair used when you provision a project as a service catalog
/// product. For information, see [What is Amazon Web Services Service
/// Catalog](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/introduction.html).
pub const ProvisioningParameter = struct {
    /// The key that identifies a provisioning parameter.
    key: ?[]const u8 = null,

    /// The value of the provisioning parameter.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
