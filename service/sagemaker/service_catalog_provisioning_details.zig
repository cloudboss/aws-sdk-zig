const ProvisioningParameter = @import("provisioning_parameter.zig").ProvisioningParameter;

/// Details that you specify to provision a service catalog product. For
/// information about service catalog, see [What is Amazon Web Services Service
/// Catalog](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/introduction.html).
pub const ServiceCatalogProvisioningDetails = struct {
    /// The path identifier of the product. This value is optional if the product
    /// has a default path, and required if the product has more than one path.
    path_id: ?[]const u8,

    /// The ID of the product to provision.
    product_id: []const u8,

    /// The ID of the provisioning artifact.
    provisioning_artifact_id: ?[]const u8,

    /// A list of key value pairs that you specify when you provision a product.
    provisioning_parameters: ?[]const ProvisioningParameter,

    pub const json_field_names = .{
        .path_id = "PathId",
        .product_id = "ProductId",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .provisioning_parameters = "ProvisioningParameters",
    };
};
