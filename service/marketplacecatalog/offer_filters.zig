const OfferAvailabilityEndDateFilter = @import("offer_availability_end_date_filter.zig").OfferAvailabilityEndDateFilter;
const OfferBuyerAccountsFilter = @import("offer_buyer_accounts_filter.zig").OfferBuyerAccountsFilter;
const OfferEntityIdFilter = @import("offer_entity_id_filter.zig").OfferEntityIdFilter;
const OfferLastModifiedDateFilter = @import("offer_last_modified_date_filter.zig").OfferLastModifiedDateFilter;
const OfferNameFilter = @import("offer_name_filter.zig").OfferNameFilter;
const OfferSetIdFilter = @import("offer_set_id_filter.zig").OfferSetIdFilter;
const OfferProductIdFilter = @import("offer_product_id_filter.zig").OfferProductIdFilter;
const OfferReleaseDateFilter = @import("offer_release_date_filter.zig").OfferReleaseDateFilter;
const OfferResaleAuthorizationIdFilter = @import("offer_resale_authorization_id_filter.zig").OfferResaleAuthorizationIdFilter;
const OfferStateFilter = @import("offer_state_filter.zig").OfferStateFilter;
const OfferTargetingFilter = @import("offer_targeting_filter.zig").OfferTargetingFilter;

/// Object containing all the filter fields for offers entity. Client can add
/// only one wildcard filter and a maximum of 8 filters in a single
/// `ListEntities` request.
pub const OfferFilters = struct {
    /// Allows filtering on the `AvailabilityEndDate` of an offer.
    availability_end_date: ?OfferAvailabilityEndDateFilter = null,

    /// Allows filtering on the `BuyerAccounts` of an offer.
    buyer_accounts: ?OfferBuyerAccountsFilter = null,

    /// Allows filtering on `EntityId` of an offer.
    entity_id: ?OfferEntityIdFilter = null,

    /// Allows filtering on the `LastModifiedDate` of an offer.
    last_modified_date: ?OfferLastModifiedDateFilter = null,

    /// Allows filtering on the `Name` of an offer.
    name: ?OfferNameFilter = null,

    /// Allows filtering on the `OfferSetId` of an offer.
    offer_set_id: ?OfferSetIdFilter = null,

    /// Allows filtering on the `ProductId` of an offer.
    product_id: ?OfferProductIdFilter = null,

    /// Allows filtering on the `ReleaseDate` of an offer.
    release_date: ?OfferReleaseDateFilter = null,

    /// Allows filtering on the `ResaleAuthorizationId` of an offer.
    ///
    /// Not all offers have a `ResaleAuthorizationId`. The response will only
    /// include offers for which you have permissions.
    resale_authorization_id: ?OfferResaleAuthorizationIdFilter = null,

    /// Allows filtering on the `State` of an offer.
    state: ?OfferStateFilter = null,

    /// Allows filtering on the `Targeting` of an offer.
    targeting: ?OfferTargetingFilter = null,

    pub const json_field_names = .{
        .availability_end_date = "AvailabilityEndDate",
        .buyer_accounts = "BuyerAccounts",
        .entity_id = "EntityId",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .offer_set_id = "OfferSetId",
        .product_id = "ProductId",
        .release_date = "ReleaseDate",
        .resale_authorization_id = "ResaleAuthorizationId",
        .state = "State",
        .targeting = "Targeting",
    };
};
