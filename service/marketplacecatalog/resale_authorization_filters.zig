const ResaleAuthorizationAvailabilityEndDateFilter = @import("resale_authorization_availability_end_date_filter.zig").ResaleAuthorizationAvailabilityEndDateFilter;
const ResaleAuthorizationCreatedDateFilter = @import("resale_authorization_created_date_filter.zig").ResaleAuthorizationCreatedDateFilter;
const ResaleAuthorizationEntityIdFilter = @import("resale_authorization_entity_id_filter.zig").ResaleAuthorizationEntityIdFilter;
const ResaleAuthorizationLastModifiedDateFilter = @import("resale_authorization_last_modified_date_filter.zig").ResaleAuthorizationLastModifiedDateFilter;
const ResaleAuthorizationManufacturerAccountIdFilter = @import("resale_authorization_manufacturer_account_id_filter.zig").ResaleAuthorizationManufacturerAccountIdFilter;
const ResaleAuthorizationManufacturerLegalNameFilter = @import("resale_authorization_manufacturer_legal_name_filter.zig").ResaleAuthorizationManufacturerLegalNameFilter;
const ResaleAuthorizationNameFilter = @import("resale_authorization_name_filter.zig").ResaleAuthorizationNameFilter;
const ResaleAuthorizationOfferExtendedStatusFilter = @import("resale_authorization_offer_extended_status_filter.zig").ResaleAuthorizationOfferExtendedStatusFilter;
const ResaleAuthorizationProductIdFilter = @import("resale_authorization_product_id_filter.zig").ResaleAuthorizationProductIdFilter;
const ResaleAuthorizationProductNameFilter = @import("resale_authorization_product_name_filter.zig").ResaleAuthorizationProductNameFilter;
const ResaleAuthorizationResellerAccountIDFilter = @import("resale_authorization_reseller_account_id_filter.zig").ResaleAuthorizationResellerAccountIDFilter;
const ResaleAuthorizationResellerLegalNameFilter = @import("resale_authorization_reseller_legal_name_filter.zig").ResaleAuthorizationResellerLegalNameFilter;
const ResaleAuthorizationStatusFilter = @import("resale_authorization_status_filter.zig").ResaleAuthorizationStatusFilter;

/// Object containing all the filter fields for resale authorization entity.
/// Client can add only one wildcard filter and a maximum of 8 filters in a
/// single `ListEntities` request.
pub const ResaleAuthorizationFilters = struct {
    /// Allows filtering on the `AvailabilityEndDate` of a ResaleAuthorization.
    availability_end_date: ?ResaleAuthorizationAvailabilityEndDateFilter,

    /// Allows filtering on the `CreatedDate` of a ResaleAuthorization.
    created_date: ?ResaleAuthorizationCreatedDateFilter,

    /// Allows filtering on the `EntityId` of a ResaleAuthorization.
    entity_id: ?ResaleAuthorizationEntityIdFilter,

    /// Allows filtering on the `LastModifiedDate` of a ResaleAuthorization.
    last_modified_date: ?ResaleAuthorizationLastModifiedDateFilter,

    /// Allows filtering on the `ManufacturerAccountId` of a ResaleAuthorization.
    manufacturer_account_id: ?ResaleAuthorizationManufacturerAccountIdFilter,

    /// Allows filtering on the `ManufacturerLegalName` of a ResaleAuthorization.
    manufacturer_legal_name: ?ResaleAuthorizationManufacturerLegalNameFilter,

    /// Allows filtering on the `Name` of a ResaleAuthorization.
    name: ?ResaleAuthorizationNameFilter,

    /// Allows filtering on the `OfferExtendedStatus` of a ResaleAuthorization.
    offer_extended_status: ?ResaleAuthorizationOfferExtendedStatusFilter,

    /// Allows filtering on the `ProductId` of a ResaleAuthorization.
    product_id: ?ResaleAuthorizationProductIdFilter,

    /// Allows filtering on the `ProductName` of a ResaleAuthorization.
    product_name: ?ResaleAuthorizationProductNameFilter,

    /// Allows filtering on the `ResellerAccountID` of a ResaleAuthorization.
    reseller_account_id: ?ResaleAuthorizationResellerAccountIDFilter,

    /// Allows filtering on the `ResellerLegalName` of a ResaleAuthorization.
    reseller_legal_name: ?ResaleAuthorizationResellerLegalNameFilter,

    /// Allows filtering on the `Status` of a ResaleAuthorization.
    status: ?ResaleAuthorizationStatusFilter,

    pub const json_field_names = .{
        .availability_end_date = "AvailabilityEndDate",
        .created_date = "CreatedDate",
        .entity_id = "EntityId",
        .last_modified_date = "LastModifiedDate",
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
