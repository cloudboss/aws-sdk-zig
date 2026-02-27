const ControlPlaneAttributeFilter = @import("control_plane_attribute_filter.zig").ControlPlaneAttributeFilter;

/// Filters to be applied to search results.
pub const UserHierarchyGroupSearchFilter = struct {
    /// An object that can be used to specify Tag conditions inside the
    /// SearchFilter. This accepts an OR or AND (List of
    /// List) input where:
    ///
    /// * The top level list specifies conditions that need to be applied with `OR`
    ///   operator.
    ///
    /// * The inner list specifies conditions that need to be applied with `AND`
    ///   operator.
    attribute_filter: ?ControlPlaneAttributeFilter,

    pub const json_field_names = .{
        .attribute_filter = "AttributeFilter",
    };
};
