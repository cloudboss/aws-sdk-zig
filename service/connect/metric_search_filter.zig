const ControlPlaneTagFilter = @import("control_plane_tag_filter.zig").ControlPlaneTagFilter;

/// Filters to apply when searching for metrics.
pub const MetricSearchFilter = struct {
    /// An object that can be used to specify tag conditions inside the
    /// `SearchFilter`. This accepts an OR of AND (List of List) input where:
    ///
    /// * The top level list specifies conditions that need to be applied with OR
    ///   operator.
    ///
    /// * The inner list specifies conditions that need to be applied with AND
    ///   operator.
    tag_filter: ?ControlPlaneTagFilter = null,

    pub const json_field_names = .{
        .tag_filter = "TagFilter",
    };
};
