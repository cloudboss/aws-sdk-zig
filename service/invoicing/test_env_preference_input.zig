const BuyerDomain = @import("buyer_domain.zig").BuyerDomain;
const SupplierDomain = @import("supplier_domain.zig").SupplierDomain;

/// Input parameters for configuring test environment preferences for a
/// procurement portal.
pub const TestEnvPreferenceInput = struct {
    /// The domain identifier to use for the buyer in the test environment.
    buyer_domain: BuyerDomain,

    /// The unique identifier to use for the buyer in the test environment.
    buyer_identifier: []const u8,

    /// The endpoint URL where e-invoices will be delivered in the test environment.
    procurement_portal_instance_endpoint: ?[]const u8 = null,

    /// The shared secret or authentication credential to use for secure
    /// communication in the test environment.
    procurement_portal_shared_secret: ?[]const u8 = null,

    /// The domain identifier to use for the supplier in the test environment.
    supplier_domain: SupplierDomain,

    /// The unique identifier to use for the supplier in the test environment.
    supplier_identifier: []const u8,

    pub const json_field_names = .{
        .buyer_domain = "BuyerDomain",
        .buyer_identifier = "BuyerIdentifier",
        .procurement_portal_instance_endpoint = "ProcurementPortalInstanceEndpoint",
        .procurement_portal_shared_secret = "ProcurementPortalSharedSecret",
        .supplier_domain = "SupplierDomain",
        .supplier_identifier = "SupplierIdentifier",
    };
};
