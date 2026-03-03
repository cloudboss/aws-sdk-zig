const FulfillmentType = @import("fulfillment_type.zig").FulfillmentType;
const BenefitAllocationStatus = @import("benefit_allocation_status.zig").BenefitAllocationStatus;

/// A summary view of a benefit allocation containing key information for list
/// operations.
pub const BenefitAllocationSummary = struct {
    /// The identifiers of the benefits applicable for this allocation.
    applicable_benefit_ids: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the benefit allocation.
    arn: ?[]const u8 = null,

    /// The identifier of the benefit application that resulted in this allocation.
    benefit_application_id: ?[]const u8 = null,

    /// The identifier of the benefit that this allocation is based on.
    benefit_id: ?[]const u8 = null,

    /// The catalog identifier that the benefit allocation belongs to.
    catalog: ?[]const u8 = null,

    /// The timestamp when the benefit allocation was created.
    created_at: ?i64 = null,

    /// The timestamp when the benefit allocation expires.
    expires_at: ?i64 = null,

    /// The fulfillment types used for this benefit allocation.
    fulfillment_types: ?[]const FulfillmentType = null,

    /// The unique identifier of the benefit allocation.
    id: ?[]const u8 = null,

    /// The human-readable name of the benefit allocation.
    name: ?[]const u8 = null,

    /// The current status of the benefit allocation.
    status: ?BenefitAllocationStatus = null,

    /// Additional information explaining the current status of the benefit
    /// allocation.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .applicable_benefit_ids = "ApplicableBenefitIds",
        .arn = "Arn",
        .benefit_application_id = "BenefitApplicationId",
        .benefit_id = "BenefitId",
        .catalog = "Catalog",
        .created_at = "CreatedAt",
        .expires_at = "ExpiresAt",
        .fulfillment_types = "FulfillmentTypes",
        .id = "Id",
        .name = "Name",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};
