const EntityFilterName = @import("entity_filter_name.zig").EntityFilterName;

/// An object that filters an entity search. Multiple filters function as OR
/// criteria in the search. For example a search that includes
/// a `NAMESPACE` and a `REFERENCED_ENTITY_ID` filter searches for entities in
/// the specified namespace that use the entity specified by
/// the value of `REFERENCED_ENTITY_ID`.
pub const EntityFilter = struct {
    /// The name of the entity search filter field. `REFERENCED_ENTITY_ID` filters
    /// on entities that are used by the entity in the result set. For example,
    /// you can filter on the ID of a property that is used in a state.
    name: ?EntityFilterName,

    /// An array of string values for the search filter field. Multiple values
    /// function as AND criteria in the search.
    value: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
