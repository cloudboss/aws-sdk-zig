pub const OfferSortBy = enum {
    entity_id,
    name,
    product_id,
    resale_authorization_id,
    release_date,
    availability_end_date,
    buyer_accounts,
    state,
    targeting,
    last_modified_date,
    offer_set_id,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .name = "Name",
        .product_id = "ProductId",
        .resale_authorization_id = "ResaleAuthorizationId",
        .release_date = "ReleaseDate",
        .availability_end_date = "AvailabilityEndDate",
        .buyer_accounts = "BuyerAccounts",
        .state = "State",
        .targeting = "Targeting",
        .last_modified_date = "LastModifiedDate",
        .offer_set_id = "OfferSetId",
    };
};
