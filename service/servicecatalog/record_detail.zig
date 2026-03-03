const RecordError = @import("record_error.zig").RecordError;
const RecordTag = @import("record_tag.zig").RecordTag;
const RecordStatus = @import("record_status.zig").RecordStatus;

/// Information about a request operation.
pub const RecordDetail = struct {
    /// The UTC time stamp of the creation time.
    created_time: ?i64 = null,

    /// The ARN of the launch role associated with the provisioned product.
    launch_role_arn: ?[]const u8 = null,

    /// The path identifier.
    path_id: ?[]const u8 = null,

    /// The product identifier.
    product_id: ?[]const u8 = null,

    /// The identifier of the provisioned product.
    provisioned_product_id: ?[]const u8 = null,

    /// The user-friendly name of the provisioned product.
    provisioned_product_name: ?[]const u8 = null,

    /// The type of provisioned product. The supported values are `CFN_STACK`,
    /// `CFN_STACKSET`,
    /// `TERRAFORM_OPEN_SOURCE`, `TERRAFORM_CLOUD`, and `EXTERNAL`.
    provisioned_product_type: ?[]const u8 = null,

    /// The identifier of the provisioning artifact.
    provisioning_artifact_id: ?[]const u8 = null,

    /// The errors that occurred.
    record_errors: ?[]const RecordError = null,

    /// The identifier of the record.
    record_id: ?[]const u8 = null,

    /// One or more tags.
    record_tags: ?[]const RecordTag = null,

    /// The record type.
    ///
    /// * `PROVISION_PRODUCT`
    ///
    /// * `UPDATE_PROVISIONED_PRODUCT`
    ///
    /// * `TERMINATE_PROVISIONED_PRODUCT`
    record_type: ?[]const u8 = null,

    /// The status of the provisioned product.
    ///
    /// * `CREATED` - The request was created but the operation has not started.
    ///
    /// * `IN_PROGRESS` - The requested operation is in progress.
    ///
    /// * `IN_PROGRESS_IN_ERROR` - The provisioned product is under change but the
    /// requested operation failed and some remediation is occurring. For example, a
    /// rollback.
    ///
    /// * `SUCCEEDED` - The requested operation has successfully completed.
    ///
    /// * `FAILED` - The requested operation has unsuccessfully completed.
    /// Investigate using the error messages returned.
    status: ?RecordStatus = null,

    /// The time when the record was last updated.
    updated_time: ?i64 = null,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .launch_role_arn = "LaunchRoleArn",
        .path_id = "PathId",
        .product_id = "ProductId",
        .provisioned_product_id = "ProvisionedProductId",
        .provisioned_product_name = "ProvisionedProductName",
        .provisioned_product_type = "ProvisionedProductType",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .record_errors = "RecordErrors",
        .record_id = "RecordId",
        .record_tags = "RecordTags",
        .record_type = "RecordType",
        .status = "Status",
        .updated_time = "UpdatedTime",
    };
};
