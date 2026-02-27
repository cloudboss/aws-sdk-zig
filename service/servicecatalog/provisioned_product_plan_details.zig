const ProvisionedProductPlanType = @import("provisioned_product_plan_type.zig").ProvisionedProductPlanType;
const UpdateProvisioningParameter = @import("update_provisioning_parameter.zig").UpdateProvisioningParameter;
const ProvisionedProductPlanStatus = @import("provisioned_product_plan_status.zig").ProvisionedProductPlanStatus;
const Tag = @import("tag.zig").Tag;

/// Information about a plan.
pub const ProvisionedProductPlanDetails = struct {
    /// The UTC time stamp of the creation time.
    created_time: ?i64,

    /// Passed to CloudFormation. The SNS topic ARNs to which to publish
    /// stack-related
    /// events.
    notification_arns: ?[]const []const u8,

    /// The path identifier of the product. This value is optional if the product
    /// has a default path, and required if the product has more than one path.
    /// To list the paths for a product, use ListLaunchPaths.
    path_id: ?[]const u8,

    /// The plan identifier.
    plan_id: ?[]const u8,

    /// The name of the plan.
    plan_name: ?[]const u8,

    /// The plan type.
    plan_type: ?ProvisionedProductPlanType,

    /// The product identifier.
    product_id: ?[]const u8,

    /// The identifier of the provisioning artifact.
    provisioning_artifact_id: ?[]const u8,

    /// Parameters specified by the administrator that are required for provisioning
    /// the
    /// product.
    provisioning_parameters: ?[]const UpdateProvisioningParameter,

    /// The product identifier.
    provision_product_id: ?[]const u8,

    /// The user-friendly name of the provisioned product.
    provision_product_name: ?[]const u8,

    /// The status.
    status: ?ProvisionedProductPlanStatus,

    /// The status message.
    status_message: ?[]const u8,

    /// One or more tags.
    tags: ?[]const Tag,

    /// The UTC time stamp when the plan was last updated.
    updated_time: ?i64,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .notification_arns = "NotificationArns",
        .path_id = "PathId",
        .plan_id = "PlanId",
        .plan_name = "PlanName",
        .plan_type = "PlanType",
        .product_id = "ProductId",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .provisioning_parameters = "ProvisioningParameters",
        .provision_product_id = "ProvisionProductId",
        .provision_product_name = "ProvisionProductName",
        .status = "Status",
        .status_message = "StatusMessage",
        .tags = "Tags",
        .updated_time = "UpdatedTime",
    };
};
