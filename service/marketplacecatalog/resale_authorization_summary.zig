const ResaleAuthorizationStatusString = @import("resale_authorization_status_string.zig").ResaleAuthorizationStatusString;

/// Summarized information about a Resale Authorization.
pub const ResaleAuthorizationSummary = struct {
    /// The availability end date of the ResaleAuthorization.
    availability_end_date: ?[]const u8,

    /// The created date of the ResaleAuthorization.
    created_date: ?[]const u8,

    /// The manufacturer account ID of the ResaleAuthorization.
    manufacturer_account_id: ?[]const u8,

    /// The manufacturer legal name of the ResaleAuthorization.
    manufacturer_legal_name: ?[]const u8,

    /// The name of the ResaleAuthorization.
    name: ?[]const u8,

    /// The offer extended status of the ResaleAuthorization
    offer_extended_status: ?[]const u8,

    /// The product ID of the ResaleAuthorization.
    product_id: ?[]const u8,

    /// The product name of the ResaleAuthorization.
    product_name: ?[]const u8,

    /// The reseller account ID of the ResaleAuthorization.
    reseller_account_id: ?[]const u8,

    /// The reseller legal name of the ResaleAuthorization
    reseller_legal_name: ?[]const u8,

    /// The status of the ResaleAuthorization.
    status: ?ResaleAuthorizationStatusString,

    pub const json_field_names = .{
        .availability_end_date = "AvailabilityEndDate",
        .created_date = "CreatedDate",
        .manufacturer_account_id = "ManufacturerAccountId",
        .manufacturer_legal_name = "ManufacturerLegalName",
        .name = "Name",
        .offer_extended_status = "OfferExtendedStatus",
        .product_id = "ProductId",
        .product_name = "ProductName",
        .reseller_account_id = "ResellerAccountID",
        .reseller_legal_name = "ResellerLegalName",
        .status = "Status",
    };
};
