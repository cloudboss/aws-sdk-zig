const ProvisionedProductStatus = @import("provisioned_product_status.zig").ProvisionedProductStatus;

/// Information about a provisioned product.
pub const ProvisionedProductDetail = struct {
    /// The ARN of the provisioned product.
    arn: ?[]const u8,

    /// The UTC time stamp of the creation time.
    created_time: ?i64,

    /// The identifier of the provisioned product.
    id: ?[]const u8,

    /// A unique identifier that you provide to ensure idempotency. If multiple
    /// requests differ only by the idempotency token,
    /// the same response is returned for each repeated request.
    idempotency_token: ?[]const u8,

    /// The record identifier of the last request performed on this provisioned
    /// product of the following types:
    ///
    /// * ProvisionProduct
    ///
    /// * UpdateProvisionedProduct
    ///
    /// * ExecuteProvisionedProductPlan
    ///
    /// * TerminateProvisionedProduct
    last_provisioning_record_id: ?[]const u8,

    /// The record identifier of the last request performed on this provisioned
    /// product.
    last_record_id: ?[]const u8,

    /// The record identifier of the last successful request performed on this
    /// provisioned product of the following types:
    ///
    /// * ProvisionProduct
    ///
    /// * UpdateProvisionedProduct
    ///
    /// * ExecuteProvisionedProductPlan
    ///
    /// * TerminateProvisionedProduct
    last_successful_provisioning_record_id: ?[]const u8,

    /// The ARN of the launch role associated with the provisioned product.
    launch_role_arn: ?[]const u8,

    /// The user-friendly name of the provisioned product.
    name: ?[]const u8,

    /// The product identifier. For example, `prod-abcdzk7xy33qa`.
    product_id: ?[]const u8,

    /// The identifier of the provisioning artifact. For example,
    /// `pa-4abcdjnxjj6ne`.
    provisioning_artifact_id: ?[]const u8,

    /// The current status of the provisioned product.
    ///
    /// * `AVAILABLE` - Stable state, ready to perform any operation. The most
    /// recent operation succeeded and completed.
    ///
    /// * `UNDER_CHANGE` - Transitive state. Operations performed might not have
    ///   valid results.
    /// Wait for an `AVAILABLE` status before performing operations.
    ///
    /// * `TAINTED` - Stable state, ready to perform any operation. The stack has
    /// completed the requested operation but is not exactly what was requested. For
    /// example, a
    /// request to update to a new version failed and the stack rolled back to the
    /// current version.
    ///
    /// * `ERROR` - An unexpected error occurred. The provisioned product exists but
    ///   the stack is not running.
    /// For example, CloudFormation received a parameter value that was not valid
    /// and could not launch the stack.
    ///
    /// * `PLAN_IN_PROGRESS` - Transitive state. The plan operations were performed
    ///   to provision a new product,
    /// but resources have not yet been created. After reviewing the list of
    /// resources to be created, execute the plan. Wait for an `AVAILABLE` status
    /// before performing operations.
    status: ?ProvisionedProductStatus,

    /// The current status message of the provisioned product.
    status_message: ?[]const u8,

    /// The type of provisioned product.
    /// The supported values are `CFN_STACK`, `CFN_STACKSET`,
    /// `TERRAFORM_OPEN_SOURCE`,
    /// `TERRAFORM_CLOUD`, and `EXTERNAL`.
    type: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .id = "Id",
        .idempotency_token = "IdempotencyToken",
        .last_provisioning_record_id = "LastProvisioningRecordId",
        .last_record_id = "LastRecordId",
        .last_successful_provisioning_record_id = "LastSuccessfulProvisioningRecordId",
        .launch_role_arn = "LaunchRoleArn",
        .name = "Name",
        .product_id = "ProductId",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .status = "Status",
        .status_message = "StatusMessage",
        .type = "Type",
    };
};
