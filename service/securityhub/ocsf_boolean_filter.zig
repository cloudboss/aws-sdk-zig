const OcsfBooleanField = @import("ocsf_boolean_field.zig").OcsfBooleanField;
const BooleanFilter = @import("boolean_filter.zig").BooleanFilter;

/// Enables filtering of security findings based on boolean field values in
/// OCSF.
pub const OcsfBooleanFilter = struct {
    /// The name of the field.
    field_name: ?OcsfBooleanField,

    filter: ?BooleanFilter,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
