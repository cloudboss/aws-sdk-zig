const CustomFieldsFilter = @import("custom_fields_filter.zig").CustomFieldsFilter;

/// A filter for related items of type `Custom`.
pub const CustomFilter = struct {
    /// Filter conditions for custom fields.
    fields: ?CustomFieldsFilter,

    pub const json_field_names = .{
        .fields = "fields",
    };
};
