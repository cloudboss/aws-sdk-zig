const TreeMapAggregatedFieldWells = @import("tree_map_aggregated_field_wells.zig").TreeMapAggregatedFieldWells;

/// The field wells of a tree map.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const TreeMapFieldWells = struct {
    /// The aggregated field wells of a tree map.
    tree_map_aggregated_field_wells: ?TreeMapAggregatedFieldWells,

    pub const json_field_names = .{
        .tree_map_aggregated_field_wells = "TreeMapAggregatedFieldWells",
    };
};
