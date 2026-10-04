const RemediationCompositeFilter = @import("remediation_composite_filter.zig").RemediationCompositeFilter;

/// Contains the criteria used to filter remediation targets, such as resource
/// type, priority,
/// or status.
pub const RemediationFilters = struct {
    /// A collection of complex filtering conditions that can be applied to
    /// remediation target data.
    composite_filters: ?[]const RemediationCompositeFilter = null,

    pub const json_field_names = .{
        .composite_filters = "CompositeFilters",
    };
};
