const ServiceActionAssociationErrorCode = @import("service_action_association_error_code.zig").ServiceActionAssociationErrorCode;

/// An object containing information about the error, along with identifying
/// information about the self-service action and its associations.
pub const FailedServiceActionAssociation = struct {
    /// The error code. Valid values are listed below.
    error_code: ?ServiceActionAssociationErrorCode,

    /// A text description of the error.
    error_message: ?[]const u8,

    /// The product identifier. For example, `prod-abcdzk7xy33qa`.
    product_id: ?[]const u8,

    /// The identifier of the provisioning artifact. For example,
    /// `pa-4abcdjnxjj6ne`.
    provisioning_artifact_id: ?[]const u8,

    /// The self-service action identifier. For example, `act-fs7abcd89wxyz`.
    service_action_id: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .product_id = "ProductId",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .service_action_id = "ServiceActionId",
    };
};
