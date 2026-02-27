const ProvisionedProductPlanType = @import("provisioned_product_plan_type.zig").ProvisionedProductPlanType;

/// Summary information about a plan.
pub const ProvisionedProductPlanSummary = struct {
    /// The plan identifier.
    plan_id: ?[]const u8,

    /// The name of the plan.
    plan_name: ?[]const u8,

    /// The plan type.
    plan_type: ?ProvisionedProductPlanType,

    /// The identifier of the provisioning artifact.
    provisioning_artifact_id: ?[]const u8,

    /// The product identifier.
    provision_product_id: ?[]const u8,

    /// The user-friendly name of the provisioned product.
    provision_product_name: ?[]const u8,

    pub const json_field_names = .{
        .plan_id = "PlanId",
        .plan_name = "PlanName",
        .plan_type = "PlanType",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .provision_product_id = "ProvisionProductId",
        .provision_product_name = "ProvisionProductName",
    };
};
