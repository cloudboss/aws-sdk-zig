const OcsfDateField = @import("ocsf_date_field.zig").OcsfDateField;
const DateFilter = @import("date_filter.zig").DateFilter;

/// Enables filtering of security findings based on date and timestamp fields in
/// OCSF.
pub const OcsfDateFilter = struct {
    /// The name of the field.
    field_name: ?OcsfDateField,

    filter: ?DateFilter,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
