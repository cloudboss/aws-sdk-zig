const RemediationStringFilter = @import("remediation_string_filter.zig").RemediationStringFilter;

/// Enables the creation of criteria for remediation targets.
pub const RemediationCompositeFilter = struct {
    /// Enables filtering based on string field values.
    string_filters: ?[]const RemediationStringFilter = null,

    pub const json_field_names = .{
        .string_filters = "StringFilters",
    };
};
