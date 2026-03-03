const ProvisionedProductStatus = @import("provisioned_product_status.zig").ProvisionedProductStatus;
const Tag = @import("tag.zig").Tag;

/// Information about a provisioned product.
pub const ProvisionedProductAttribute = struct {
    /// The ARN of the provisioned product.
    arn: ?[]const u8 = null,

    /// The UTC time stamp of the creation time.
    created_time: ?i64 = null,

    /// The identifier of the provisioned product.
    id: ?[]const u8 = null,

    /// A unique identifier that you provide to ensure idempotency. If multiple
    /// requests differ only by the idempotency token,
    /// the same response is returned for each repeated request.
    idempotency_token: ?[]const u8 = null,

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
    last_provisioning_record_id: ?[]const u8 = null,

    /// The record identifier of the last request performed on this provisioned
    /// product.
    last_record_id: ?[]const u8 = null,

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
    last_successful_provisioning_record_id: ?[]const u8 = null,

    /// The user-friendly name of the provisioned product.
    name: ?[]const u8 = null,

    /// The assigned identifier for the resource, such as an EC2 instance ID or an
    /// S3 bucket name.
    physical_id: ?[]const u8 = null,

    /// The product identifier.
    product_id: ?[]const u8 = null,

    /// The name of the product.
    product_name: ?[]const u8 = null,

    /// The identifier of the provisioning artifact.
    provisioning_artifact_id: ?[]const u8 = null,

    /// The name of the provisioning artifact.
    provisioning_artifact_name: ?[]const u8 = null,

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
    status: ?ProvisionedProductStatus = null,

    /// The current status message of the provisioned product.
    status_message: ?[]const u8 = null,

    /// One or more tags.
    tags: ?[]const Tag = null,

    /// The type of provisioned product.
    /// The supported values are `CFN_STACK`, `CFN_STACKSET`,
    /// `TERRAFORM_OPEN_SOURCE`,
    /// `TERRAFORM_CLOUD`, and `EXTERNAL`.
    @"type": ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the user.
    user_arn: ?[]const u8 = null,

    /// The ARN of the user in the session. This ARN might contain a session ID.
    user_arn_session: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .id = "Id",
        .idempotency_token = "IdempotencyToken",
        .last_provisioning_record_id = "LastProvisioningRecordId",
        .last_record_id = "LastRecordId",
        .last_successful_provisioning_record_id = "LastSuccessfulProvisioningRecordId",
        .name = "Name",
        .physical_id = "PhysicalId",
        .product_id = "ProductId",
        .product_name = "ProductName",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .provisioning_artifact_name = "ProvisioningArtifactName",
        .status = "Status",
        .status_message = "StatusMessage",
        .tags = "Tags",
        .@"type" = "Type",
        .user_arn = "UserArn",
        .user_arn_session = "UserArnSession",
    };
};
