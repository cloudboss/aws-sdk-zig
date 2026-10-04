const ProcurementPortalEnv = @import("procurement_portal_env.zig").ProcurementPortalEnv;

/// Contains metadata for a supplier configured within a procurement portal.
pub const ProcurementPortalSupplier = struct {
    /// The two-letter ISO 3166-1 alpha-2 country code associated with the supplier.
    country_code: ?[]const u8 = null,

    /// The environment identifier for the supplier in the procurement portal. PROD
    /// for production env, or TEST for sandbox/test env.
    environment: ?ProcurementPortalEnv = null,

    /// The Amazon Web Services seller of record associated with the supplier—the
    /// Amazon Web Services legal entity that issues invoices for the account (for
    /// example, `AWS_INC` or `AWS_EUROPE`).
    seller_of_record: ?[]const u8 = null,

    /// The unique identifier of the supplier within the procurement portal.
    supplier_identifier: []const u8,

    pub const json_field_names = .{
        .country_code = "CountryCode",
        .environment = "Environment",
        .seller_of_record = "SellerOfRecord",
        .supplier_identifier = "SupplierIdentifier",
    };
};
