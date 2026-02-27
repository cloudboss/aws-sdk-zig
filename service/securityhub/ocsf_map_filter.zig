const OcsfMapField = @import("ocsf_map_field.zig").OcsfMapField;
const MapFilter = @import("map_filter.zig").MapFilter;

/// Enables filtering of security findings based on map field values in OCSF.
pub const OcsfMapFilter = struct {
    /// The name of the field.
    field_name: ?OcsfMapField,

    filter: ?MapFilter,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
