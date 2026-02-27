const FilterByComponentType = @import("filter_by_component_type.zig").FilterByComponentType;
const FilterByEntity = @import("filter_by_entity.zig").FilterByEntity;

/// The metadata transfer job AWS IoT TwinMaker source configuration filter.
pub const IotTwinMakerSourceConfigurationFilter = union(enum) {
    /// Filter by component type.
    filter_by_component_type: ?FilterByComponentType,
    /// Filter by entity.
    filter_by_entity: ?FilterByEntity,

    pub const json_field_names = .{
        .filter_by_component_type = "filterByComponentType",
        .filter_by_entity = "filterByEntity",
    };
};
