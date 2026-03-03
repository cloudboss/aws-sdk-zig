/// Capacity limits for a collection group. These limits define the minimum and
/// maximum OpenSearch Compute Units (OCUs) for indexing and search operations
/// that can be used by collections in the group.
pub const CollectionGroupCapacityLimits = struct {
    /// The maximum indexing capacity for collections in the group.
    max_indexing_capacity_in_ocu: ?f32 = null,

    /// The maximum search capacity for collections in the group.
    max_search_capacity_in_ocu: ?f32 = null,

    /// The minimum indexing capacity for collections in the group.
    min_indexing_capacity_in_ocu: ?f32 = null,

    /// The minimum search capacity for collections in the group.
    min_search_capacity_in_ocu: ?f32 = null,

    pub const json_field_names = .{
        .max_indexing_capacity_in_ocu = "maxIndexingCapacityInOCU",
        .max_search_capacity_in_ocu = "maxSearchCapacityInOCU",
        .min_indexing_capacity_in_ocu = "minIndexingCapacityInOCU",
        .min_search_capacity_in_ocu = "minSearchCapacityInOCU",
    };
};
