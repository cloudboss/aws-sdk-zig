const AttributeFilter = @import("attribute_filter.zig").AttributeFilter;

/// Specifies filters to apply to an allowed action.
pub const ActionFilterConfiguration = struct {
    document_attribute_filter: AttributeFilter,

    pub const json_field_names = .{
        .document_attribute_filter = "documentAttributeFilter",
    };
};
