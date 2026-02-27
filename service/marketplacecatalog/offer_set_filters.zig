const OfferSetAssociatedOfferIdsFilter = @import("offer_set_associated_offer_ids_filter.zig").OfferSetAssociatedOfferIdsFilter;
const OfferSetEntityIdFilter = @import("offer_set_entity_id_filter.zig").OfferSetEntityIdFilter;
const OfferSetLastModifiedDateFilter = @import("offer_set_last_modified_date_filter.zig").OfferSetLastModifiedDateFilter;
const OfferSetNameFilter = @import("offer_set_name_filter.zig").OfferSetNameFilter;
const OfferSetReleaseDateFilter = @import("offer_set_release_date_filter.zig").OfferSetReleaseDateFilter;
const OfferSetSolutionIdFilter = @import("offer_set_solution_id_filter.zig").OfferSetSolutionIdFilter;
const OfferSetStateFilter = @import("offer_set_state_filter.zig").OfferSetStateFilter;

/// Object containing all the filter fields for offer sets entity. Client can
/// add a maximum of 8 filters in a single `ListEntities` request.
pub const OfferSetFilters = struct {
    /// Allows filtering on the `AssociatedOfferIds` of an offer set.
    associated_offer_ids: ?OfferSetAssociatedOfferIdsFilter,

    /// Allows filtering on `EntityId` of an offer set.
    entity_id: ?OfferSetEntityIdFilter,

    /// Allows filtering on the `LastModifiedDate` of an offer set.
    last_modified_date: ?OfferSetLastModifiedDateFilter,

    /// Allows filtering on the `Name` of an offer set.
    name: ?OfferSetNameFilter,

    /// Allows filtering on the `ReleaseDate` of an offer set.
    release_date: ?OfferSetReleaseDateFilter,

    /// Allows filtering on the `SolutionId` of an offer set.
    solution_id: ?OfferSetSolutionIdFilter,

    /// Allows filtering on the `State` of an offer set.
    state: ?OfferSetStateFilter,

    pub const json_field_names = .{
        .associated_offer_ids = "AssociatedOfferIds",
        .entity_id = "EntityId",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .release_date = "ReleaseDate",
        .solution_id = "SolutionId",
        .state = "State",
    };
};
