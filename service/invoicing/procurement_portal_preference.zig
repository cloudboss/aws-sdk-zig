const BuyerDomain = @import("buyer_domain.zig").BuyerDomain;
const Contact = @import("contact.zig").Contact;
const EinvoiceDeliveryPreference = @import("einvoice_delivery_preference.zig").EinvoiceDeliveryPreference;
const ProcurementPortalPreferenceStatus = @import("procurement_portal_preference_status.zig").ProcurementPortalPreferenceStatus;
const ProcurementPortalName = @import("procurement_portal_name.zig").ProcurementPortalName;
const ProcurementPortalPreferenceSelector = @import("procurement_portal_preference_selector.zig").ProcurementPortalPreferenceSelector;
const SupplierDomain = @import("supplier_domain.zig").SupplierDomain;
const TestEnvPreference = @import("test_env_preference.zig").TestEnvPreference;

/// Represents the full configuration of a procurement portal preference,
/// including settings for e-invoice delivery and purchase order retrieval.
pub const ProcurementPortalPreference = struct {
    /// The Amazon Web Services account ID associated with this procurement portal
    /// preference.
    aws_account_id: []const u8,

    /// The domain identifier for the buyer in the procurement portal.
    buyer_domain: BuyerDomain,

    /// The unique identifier for the buyer in the procurement portal.
    buyer_identifier: []const u8,

    /// List of contact information for portal administrators and technical
    /// contacts.
    contacts: ?[]const Contact,

    /// The date and time when the procurement portal preference was created.
    create_date: i64,

    /// Indicates whether e-invoice delivery is enabled for this procurement portal
    /// preference.
    einvoice_delivery_enabled: bool,

    /// The configuration settings that specify how e-invoices are delivered to the
    /// procurement portal.
    einvoice_delivery_preference: ?EinvoiceDeliveryPreference,

    /// The current status of the e-invoice delivery preference.
    einvoice_delivery_preference_status: ?ProcurementPortalPreferenceStatus,

    /// The reason for the current e-invoice delivery preference status.
    einvoice_delivery_preference_status_reason: ?[]const u8,

    /// The date and time when the procurement portal preference was last updated.
    last_update_date: i64,

    /// The endpoint URL where e-invoices are delivered to the procurement portal.
    procurement_portal_instance_endpoint: ?[]const u8,

    /// The name of the procurement portal.
    procurement_portal_name: ProcurementPortalName,

    /// The Amazon Resource Name (ARN) of the procurement portal preference.
    procurement_portal_preference_arn: []const u8,

    /// The shared secret or authentication credential used for secure communication
    /// with the procurement portal.
    procurement_portal_shared_secret: ?[]const u8,

    /// Indicates whether purchase order retrieval is enabled for this procurement
    /// portal preference.
    purchase_order_retrieval_enabled: bool,

    /// The endpoint URL used for retrieving purchase orders from the procurement
    /// portal.
    purchase_order_retrieval_endpoint: ?[]const u8,

    /// The current status of the purchase order retrieval preference.
    purchase_order_retrieval_preference_status: ?ProcurementPortalPreferenceStatus,

    /// The reason for the current purchase order retrieval preference status.
    purchase_order_retrieval_preference_status_reason: ?[]const u8,

    selector: ?ProcurementPortalPreferenceSelector,

    /// The domain identifier for the supplier in the procurement portal.
    supplier_domain: SupplierDomain,

    /// The unique identifier for the supplier in the procurement portal.
    supplier_identifier: []const u8,

    /// Configuration on settings for the test environment of the procurement
    /// portal.
    test_env_preference: ?TestEnvPreference,

    /// The version number of the procurement portal preference configuration.
    version: i64,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .buyer_domain = "BuyerDomain",
        .buyer_identifier = "BuyerIdentifier",
        .contacts = "Contacts",
        .create_date = "CreateDate",
        .einvoice_delivery_enabled = "EinvoiceDeliveryEnabled",
        .einvoice_delivery_preference = "EinvoiceDeliveryPreference",
        .einvoice_delivery_preference_status = "EinvoiceDeliveryPreferenceStatus",
        .einvoice_delivery_preference_status_reason = "EinvoiceDeliveryPreferenceStatusReason",
        .last_update_date = "LastUpdateDate",
        .procurement_portal_instance_endpoint = "ProcurementPortalInstanceEndpoint",
        .procurement_portal_name = "ProcurementPortalName",
        .procurement_portal_preference_arn = "ProcurementPortalPreferenceArn",
        .procurement_portal_shared_secret = "ProcurementPortalSharedSecret",
        .purchase_order_retrieval_enabled = "PurchaseOrderRetrievalEnabled",
        .purchase_order_retrieval_endpoint = "PurchaseOrderRetrievalEndpoint",
        .purchase_order_retrieval_preference_status = "PurchaseOrderRetrievalPreferenceStatus",
        .purchase_order_retrieval_preference_status_reason = "PurchaseOrderRetrievalPreferenceStatusReason",
        .selector = "Selector",
        .supplier_domain = "SupplierDomain",
        .supplier_identifier = "SupplierIdentifier",
        .test_env_preference = "TestEnvPreference",
        .version = "Version",
    };
};
