const ResourcesStringField = @import("resources_string_field.zig").ResourcesStringField;
const StringFilter = @import("string_filter.zig").StringFilter;

/// Enables filtering of Amazon Web Services resources based on string field
/// values.
pub const ResourcesStringFilter = struct {
    /// The name of the field.
    field_name: ?ResourcesStringField = null,

    filter: ?StringFilter = null,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
