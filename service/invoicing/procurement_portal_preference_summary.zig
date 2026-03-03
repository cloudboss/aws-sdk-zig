const BuyerDomain = @import("buyer_domain.zig").BuyerDomain;
const ProcurementPortalPreferenceStatus = @import("procurement_portal_preference_status.zig").ProcurementPortalPreferenceStatus;
const ProcurementPortalName = @import("procurement_portal_name.zig").ProcurementPortalName;
const ProcurementPortalPreferenceSelector = @import("procurement_portal_preference_selector.zig").ProcurementPortalPreferenceSelector;
const SupplierDomain = @import("supplier_domain.zig").SupplierDomain;

/// Provides a summary of a procurement portal preference, including key
/// identifiers and status information.
pub const ProcurementPortalPreferenceSummary = struct {
    /// The Amazon Web Services account ID associated with this procurement portal
    /// preference summary.
    aws_account_id: []const u8,

    /// The domain identifier for the buyer in the procurement portal.
    buyer_domain: BuyerDomain,

    /// The unique identifier for the buyer in the procurement portal.
    buyer_identifier: []const u8,

    /// The date and time when the procurement portal preference was created.
    create_date: i64,

    /// Indicates whether e-invoice delivery is enabled for this procurement portal
    /// preference.
    einvoice_delivery_enabled: bool,

    /// The current status of the e-invoice delivery preference in this summary.
    einvoice_delivery_preference_status: ?ProcurementPortalPreferenceStatus = null,

    /// The reason for the current e-invoice delivery preference status in this
    /// summary.
    einvoice_delivery_preference_status_reason: ?[]const u8 = null,

    /// The date and time when the procurement portal preference was last updated.
    last_update_date: i64,

    /// The name of the procurement portal.
    procurement_portal_name: ProcurementPortalName,

    /// The Amazon Resource Name (ARN) of the procurement portal preference.
    procurement_portal_preference_arn: []const u8,

    /// Indicates whether purchase order retrieval is enabled for this procurement
    /// portal preference.
    purchase_order_retrieval_enabled: bool,

    /// The current status of the purchase order retrieval preference in this
    /// summary.
    purchase_order_retrieval_preference_status: ?ProcurementPortalPreferenceStatus = null,

    /// The reason for the current purchase order retrieval preference status in
    /// this summary.
    purchase_order_retrieval_preference_status_reason: ?[]const u8 = null,

    selector: ?ProcurementPortalPreferenceSelector = null,

    /// The domain identifier for the supplier in the procurement portal.
    supplier_domain: SupplierDomain,

    /// The unique identifier for the supplier in the procurement portal.
    supplier_identifier: []const u8,

    /// The version number of the procurement portal preference configuration in
    /// this summary.
    version: i64,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .buyer_domain = "BuyerDomain",
        .buyer_identifier = "BuyerIdentifier",
        .create_date = "CreateDate",
        .einvoice_delivery_enabled = "EinvoiceDeliveryEnabled",
        .einvoice_delivery_preference_status = "EinvoiceDeliveryPreferenceStatus",
        .einvoice_delivery_preference_status_reason = "EinvoiceDeliveryPreferenceStatusReason",
        .last_update_date = "LastUpdateDate",
        .procurement_portal_name = "ProcurementPortalName",
        .procurement_portal_preference_arn = "ProcurementPortalPreferenceArn",
        .purchase_order_retrieval_enabled = "PurchaseOrderRetrievalEnabled",
        .purchase_order_retrieval_preference_status = "PurchaseOrderRetrievalPreferenceStatus",
        .purchase_order_retrieval_preference_status_reason = "PurchaseOrderRetrievalPreferenceStatusReason",
        .selector = "Selector",
        .supplier_domain = "SupplierDomain",
        .supplier_identifier = "SupplierIdentifier",
        .version = "Version",
    };
};
