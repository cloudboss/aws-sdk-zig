const OcsfNumberField = @import("ocsf_number_field.zig").OcsfNumberField;
const NumberFilter = @import("number_filter.zig").NumberFilter;

/// Enables filtering of security findings based on numerical field values in
/// OCSF.
pub const OcsfNumberFilter = struct {
    /// The name of the field.
    field_name: ?OcsfNumberField = null,

    filter: ?NumberFilter = null,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
