const OcsfStringField = @import("ocsf_string_field.zig").OcsfStringField;
const StringFilter = @import("string_filter.zig").StringFilter;

/// Enables filtering of security findings based on string field values in OCSF.
pub const OcsfStringFilter = struct {
    /// The name of the field.
    field_name: ?OcsfStringField,

    filter: ?StringFilter,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
