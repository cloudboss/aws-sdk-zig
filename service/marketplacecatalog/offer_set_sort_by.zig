pub const OfferSetSortBy = enum {
    name,
    state,
    release_date,
    solution_id,
    entity_id,
    last_modified_date,

    pub const json_field_names = .{
        .name = "Name",
        .state = "State",
        .release_date = "ReleaseDate",
        .solution_id = "SolutionId",
        .entity_id = "EntityId",
        .last_modified_date = "LastModifiedDate",
    };
};
