const ResourcesTrendsStringField = @import("resources_trends_string_field.zig").ResourcesTrendsStringField;
const StringFilter = @import("string_filter.zig").StringFilter;

/// A filter for string-based fields in resources trend data, such as resource
/// type or account ID.
pub const ResourcesTrendsStringFilter = struct {
    /// The name of the resources field to filter on, such as resourceType,
    /// accountId, or region.
    field_name: ?ResourcesTrendsStringField,

    filter: ?StringFilter,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
