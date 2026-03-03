const FindingsTrendsStringField = @import("findings_trends_string_field.zig").FindingsTrendsStringField;
const StringFilter = @import("string_filter.zig").StringFilter;

/// A filter for string-based fields in findings trend data.
pub const FindingsTrendsStringFilter = struct {
    /// The name of the findings field to filter on.
    field_name: ?FindingsTrendsStringField = null,

    filter: ?StringFilter = null,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
