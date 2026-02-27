const BuyerDomain = @import("buyer_domain.zig").BuyerDomain;
const SupplierDomain = @import("supplier_domain.zig").SupplierDomain;

/// Contains configuration settings for testing the procurement portal
/// integration in a non-production environment.
pub const TestEnvPreference = struct {
    /// The domain identifier for the buyer in the test environment of the
    /// procurement portal.
    buyer_domain: BuyerDomain,

    /// The unique identifier for the buyer in the test environment of the
    /// procurement portal.
    buyer_identifier: []const u8,

    /// The endpoint URL where e-invoices are delivered in the test environment.
    procurement_portal_instance_endpoint: ?[]const u8,

    /// The shared secret or authentication credential used for secure communication
    /// with the test environment.
    procurement_portal_shared_secret: ?[]const u8,

    /// The endpoint URL used for retrieving purchase orders in the test
    /// environment.
    purchase_order_retrieval_endpoint: ?[]const u8,

    /// The domain identifier for the supplier in the test environment of the
    /// procurement portal.
    supplier_domain: SupplierDomain,

    /// The unique identifier for the supplier in the test environment of the
    /// procurement portal.
    supplier_identifier: []const u8,

    pub const json_field_names = .{
        .buyer_domain = "BuyerDomain",
        .buyer_identifier = "BuyerIdentifier",
        .procurement_portal_instance_endpoint = "ProcurementPortalInstanceEndpoint",
        .procurement_portal_shared_secret = "ProcurementPortalSharedSecret",
        .purchase_order_retrieval_endpoint = "PurchaseOrderRetrievalEndpoint",
        .supplier_domain = "SupplierDomain",
        .supplier_identifier = "SupplierIdentifier",
    };
};
