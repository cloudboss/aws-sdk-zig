const ResourcesMapField = @import("resources_map_field.zig").ResourcesMapField;
const MapFilter = @import("map_filter.zig").MapFilter;

/// Enables filtering of Amazon Web Services resources based on key-value map
/// attributes.
pub const ResourcesMapFilter = struct {
    /// The name of the field.
    field_name: ?ResourcesMapField,

    filter: ?MapFilter,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
