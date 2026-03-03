const ProvisioningParameter = @import("provisioning_parameter.zig").ProvisioningParameter;

/// Details that you specify to provision a service catalog product. For
/// information about service catalog, see [What is Amazon Web Services Service
/// Catalog](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/introduction.html).
pub const ServiceCatalogProvisioningUpdateDetails = struct {
    /// The ID of the provisioning artifact.
    provisioning_artifact_id: ?[]const u8 = null,

    /// A list of key value pairs that you specify when you provision a product.
    provisioning_parameters: ?[]const ProvisioningParameter = null,

    pub const json_field_names = .{
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .provisioning_parameters = "ProvisioningParameters",
    };
};
