const ResourcesDateField = @import("resources_date_field.zig").ResourcesDateField;
const DateFilter = @import("date_filter.zig").DateFilter;

/// Enables the filtering of Amazon Web Services resources based on date and
/// timestamp attributes.
pub const ResourcesDateFilter = struct {
    /// The name of the field.
    field_name: ?ResourcesDateField,

    filter: ?DateFilter,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
