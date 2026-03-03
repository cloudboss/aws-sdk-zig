const ResourcesNumberField = @import("resources_number_field.zig").ResourcesNumberField;
const NumberFilter = @import("number_filter.zig").NumberFilter;

/// Enables filtering of Amazon Web Services resources based on numerical
/// values.
pub const ResourcesNumberFilter = struct {
    /// The name of the field.
    field_name: ?ResourcesNumberField = null,

    filter: ?NumberFilter = null,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
