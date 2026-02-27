/// A self-service action association consisting of the Action ID, the Product
/// ID, and the Provisioning Artifact ID.
pub const ServiceActionAssociation = struct {
    /// The product identifier. For example, `prod-abcdzk7xy33qa`.
    product_id: []const u8,

    /// The identifier of the provisioning artifact. For example,
    /// `pa-4abcdjnxjj6ne`.
    provisioning_artifact_id: []const u8,

    /// The self-service action identifier. For example, `act-fs7abcd89wxyz`.
    service_action_id: []const u8,

    pub const json_field_names = .{
        .product_id = "ProductId",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .service_action_id = "ServiceActionId",
    };
};
