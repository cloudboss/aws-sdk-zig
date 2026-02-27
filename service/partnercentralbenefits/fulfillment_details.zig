const AccessDetails = @import("access_details.zig").AccessDetails;
const ConsumableDetails = @import("consumable_details.zig").ConsumableDetails;
const CreditDetails = @import("credit_details.zig").CreditDetails;
const DisbursementDetails = @import("disbursement_details.zig").DisbursementDetails;

/// Contains comprehensive information about how a benefit allocation is
/// fulfilled across different fulfillment types.
pub const FulfillmentDetails = union(enum) {
    /// Details about access-based fulfillment, if applicable to this benefit
    /// allocation.
    access_details: ?AccessDetails,
    /// Details about consumable-based fulfillment, if applicable to this benefit
    /// allocation.
    consumable_details: ?ConsumableDetails,
    /// Details about credit-based fulfillment, if applicable to this benefit
    /// allocation.
    credit_details: ?CreditDetails,
    /// Details about disbursement-based fulfillment, if applicable to this benefit
    /// allocation.
    disbursement_details: ?DisbursementDetails,

    pub const json_field_names = .{
        .access_details = "AccessDetails",
        .consumable_details = "ConsumableDetails",
        .credit_details = "CreditDetails",
        .disbursement_details = "DisbursementDetails",
    };
};
