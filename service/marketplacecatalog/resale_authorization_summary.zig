const ResaleAuthorizationResellerRoleString = @import("resale_authorization_reseller_role_string.zig").ResaleAuthorizationResellerRoleString;
const ResaleAuthorizationStatusString = @import("resale_authorization_status_string.zig").ResaleAuthorizationStatusString;

/// Summarized information about a Resale Authorization.
pub const ResaleAuthorizationSummary = struct {
    /// The availability end date of the ResaleAuthorization.
    availability_end_date: ?[]const u8 = null,

    /// The created date of the ResaleAuthorization.
    created_date: ?[]const u8 = null,

    /// The issuer account ID of the ResaleAuthorization.
    issuer_account_id: ?[]const u8 = null,

    /// The manufacturer account ID of the ResaleAuthorization.
    manufacturer_account_id: ?[]const u8 = null,

    /// The manufacturer legal name of the ResaleAuthorization.
    manufacturer_legal_name: ?[]const u8 = null,

    /// The name of the ResaleAuthorization.
    name: ?[]const u8 = null,

    /// The offer extended status of the ResaleAuthorization
    offer_extended_status: ?[]const u8 = null,

    /// The product ID of the ResaleAuthorization.
    product_id: ?[]const u8 = null,

    /// The product name of the ResaleAuthorization.
    product_name: ?[]const u8 = null,

    /// The reseller account ID of the ResaleAuthorization.
    reseller_account_id: ?[]const u8 = null,

    /// The reseller legal name of the ResaleAuthorization
    reseller_legal_name: ?[]const u8 = null,

    /// The reseller role of the ResaleAuthorization.
    reseller_role: ?ResaleAuthorizationResellerRoleString = null,

    /// The source authorization of the ResaleAuthorization.
    source_authorization: ?[]const u8 = null,

    /// The status of the ResaleAuthorization.
    status: ?ResaleAuthorizationStatusString = null,

    pub const json_field_names = .{
        .availability_end_date = "AvailabilityEndDate",
        .created_date = "CreatedDate",
        .issuer_account_id = "IssuerAccountId",
        .manufacturer_account_id = "ManufacturerAccountId",
        .manufacturer_legal_name = "ManufacturerLegalName",
        .name = "Name",
        .offer_extended_status = "OfferExtendedStatus",
        .product_id = "ProductId",
        .product_name = "ProductName",
        .reseller_account_id = "ResellerAccountID",
        .reseller_legal_name = "ResellerLegalName",
        .reseller_role = "ResellerRole",
        .source_authorization = "SourceAuthorization",
        .status = "Status",
    };
};
